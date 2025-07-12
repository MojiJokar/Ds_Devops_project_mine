pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "eu-west-3"
    }
    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Terraform action to perform'
        )
    }
    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scmGit(
                        branches: [[name: 'moji/branch']],
                        extensions: [],
                        userRemoteConfigs: [[
                            url: 'https://github.com/MojiJokar/Ds_Devops_project_mine.git'
                            // credentialsId: 'github-credentials' // Uncomment if you add credentials
                        ]]
                    )
                }
            }
        }
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }
        stage('Initializing Terraform for EKS') {
            steps {
                dir('terraform/eks') {
                    sh 'terraform init'
                }
            }
        }
        stage('Formatting Terraform Code') {
            steps {
                dir('terraform/eks') {
                    sh 'terraform fmt'
                }
            }
        }
        stage('Validating Terraform') {
            steps {
                dir('terraform/eks') {
                    sh 'terraform validate'
                }
            }
        }
        stage('Previewing the Infra using Terraform') {
            steps {
                dir('terraform/eks') {
                    sh 'terraform plan'
                }
                input(message: "Are you sure to proceed?", ok: "Proceed")
            }
        }
        stage('Creating/Destroying an EKS Cluster') {
            steps {
                dir('terraform/eks') {
                    sh "terraform ${params.ACTION} --auto-approve"
                }
            }
        }
        stage('Check EKS Cluster Status') {
            steps {
                script {
                    def status = sh(
                        script: """
                            aws eks describe-cluster --region eu-west-3 --name my-eks-cluster --query 'cluster.status' --output text || echo 'NOT_FOUND'
                        """,
                        returnStdout: true
                    ).trim()
                    echo "EKS Cluster status: ${status}"
                    if (status == 'NOT_FOUND') {
                        error("EKS cluster does not exist or is not accessible.")
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform/eks/ConfigurationFiles') {
                    sh 'aws eks update-kubeconfig --region eu-west-3 --name my-eks-cluster'
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
        // Add more stages as needed
    }
}
