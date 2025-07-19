output "datadog_agent_status" {
  value = helm_release.datadog_agent.status
  description = "The status of the Datadog Helm release"
}
