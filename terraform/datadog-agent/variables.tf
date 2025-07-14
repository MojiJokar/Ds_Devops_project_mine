variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key used for the deployment"
  # value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"*/
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application Key"
  # value = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"*/
}

variable "datadog_site" {
  type        = string
  description = "Datadog Site URL"
  default = "datadoghq.eu"
}

variable "datadog_api_url" {
  type        = string
  description = "Datadog API URL"
  default     = "https://api.datadoghq.eu"
}
