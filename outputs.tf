# Datadog Outputs - Structured for module usage
output "endpoints" {
  description = "Datadog endpoints with DNS names"
  value = var.datadog.enabled ? {
    for k, v in aws_vpc_endpoint.datadog : k => {
      dns_name = local.datadog_endpoints_for_region[k].dns_name
    }
  } : {}
}

# Temporal/Supabase Output - Structured for module usage
output "endpoint" {
  description = "PrivateLink endpoint with DNS name"
  value = var.temporal.enabled && length(aws_vpc_endpoint.temporal) > 0 ? {
    dns_name = try(aws_vpc_endpoint.temporal[0].dns_entry[0].dns_name, "")
  } : (
    var.supabase.enabled && length(aws_vpc_endpoint.supabase) > 0 ? {
      dns_name = try(aws_vpc_endpoint.supabase[0].dns_entry[0].dns_name, "")
    } : null
  )
}