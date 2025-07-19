
variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key used for the deployment"
  default     = "9bef7693c3fee1874ac793162d7ac55c"
  sensitive   = true
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application Key"
  default     = "550e61c08c29657b3f870e7e01983a9e18c4865a"
  sensitive   = true
}

variable "datadog_site" {
  type        = string
  description = "Datadog Site URL"
  default     = "datadoghq.eu"
  sensitive   = true
}

variable "datadog_api_url" {
  type        = string
  description = "Datadog API URL"
  default     = "https://api.datadoghq.eu"
  sensitive   = true
}

variable "application_name" {
  type        = string
  description = "Name of the application"
  default     = "ds-devops-project-application"
  sensitive   = true
}

