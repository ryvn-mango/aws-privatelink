variable "name_prefix" {
  description = "Prefix to use for resource names"
  type        = string
}

variable "region" {
  description = "The AWS region where the resources are located"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the PrivateLink endpoint will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the PrivateLink endpoint will be created"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to attach to the endpoint"
  type        = string
}

variable "datadog" {
  description = "Configuration for Datadog PrivateLink endpoints"
  type = object({
    enabled         = bool
    endpoints       = optional(list(string), [])
    region_override = optional(string, null)
  })
  default = {
    enabled = false
  }
  
  validation {
    condition = !var.datadog.enabled || alltrue([
      for endpoint in coalesce(var.datadog.endpoints, []) : contains([
        "logs_agent",
        "logs_user",
        "api",
        "metrics",
        "containers",
        "process",
        "profiling",
        "traces",
        "database_monitoring",
        "remote_configuration"
      ], endpoint)
    ])
    error_message = "Invalid Datadog endpoint specified. Valid values are: logs_agent, logs_user, api, metrics, containers, process, profiling, traces, database_monitoring, remote_configuration"
  }
  
  validation {
    condition = !var.datadog.enabled || var.datadog.region_override == null || (var.datadog.region_override != null && contains(local.datadog_supported_regions, var.datadog.region_override))
    error_message = "Datadog region_override must be one of: ${join(", ", local.datadog_supported_regions)}"
  }
}

variable "temporal" {
  description = "Configuration for Temporal PrivateLink endpoint"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "supabase" {
  description = "Configuration for Supabase PrivateLink endpoint"
  type = object({
    enabled                    = bool
    resource_configuration_arn = string
  })
  default = {
    enabled                    = false
    resource_configuration_arn = ""
  }
  
  validation {
    condition = !var.supabase.enabled || (var.supabase.resource_configuration_arn != null && var.supabase.resource_configuration_arn != "")
    error_message = "Supabase resource_configuration_arn must be provided when Supabase is enabled"
  }
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Validation to ensure only one provider is enabled
locals {
  enabled_providers = compact([
    var.datadog.enabled ? "datadog" : "",
    var.temporal.enabled ? "temporal" : "",
    var.supabase.enabled ? "supabase" : ""
  ])
  
  enabled_providers_count = length(local.enabled_providers)
}

resource "null_resource" "validate_single_provider" {
  lifecycle {
    precondition {
      condition     = local.enabled_providers_count == 1
      error_message = local.enabled_providers_count > 1 ? "Only one provider can be enabled at a time. Currently enabled: ${join(", ", local.enabled_providers)}" : "At least one provider (datadog, temporal, or supabase) must be enabled."
    }
  }
}
