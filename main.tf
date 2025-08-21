# VPC Endpoints for Datadog (multiple endpoints)
# Datadog always uses DNS and supports cross-region
resource "aws_vpc_endpoint" "datadog" {
  for_each = local.datadog_endpoints_to_create

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = true
  service_region      = local.datadog_target_region != var.region ? local.datadog_target_region : null

  tags = merge(
    local.common_tags,
    {
      Name         = "${var.name_prefix}-datadog-privatelink-${each.key}"
      EndpointType = each.key
      Description  = each.value.description
      Region       = local.datadog_target_region
      CrossRegion  = local.datadog_target_region != var.region ? "true" : "false"
    }
  )
  
  lifecycle {
    precondition {
      condition     = local.datadog_region_valid
      error_message = var.datadog.region_override == null && !contains(local.datadog_supported_regions, var.region) ? "Your region is ${var.region}, which is not a supported Datadog region. Please provide region_override with one of: ${join(", ", local.datadog_supported_regions)}" : "Datadog endpoints can only be created in ${join(", ", local.datadog_supported_regions)}. Current target region: ${local.datadog_target_region}"
    }
  }
}

# VPC Endpoint for Temporal (single endpoint)
# No cross-region support
resource "aws_vpc_endpoint" "temporal" {
  count = var.temporal.enabled && local.temporal_service_name != "" ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = local.temporal_service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = false

  tags = merge(
    local.common_tags,
    {
      Name   = "${var.name_prefix}-temporal-privatelink"
      Region = var.region
    }
  )
  
  lifecycle {
    precondition {
      condition     = contains(local.temporal_supported_regions, var.region)
      error_message = "Temporal PrivateLink is not available in region ${var.region}. Supported regions: ${join(", ", local.temporal_supported_regions)}"
    }
  }
}

# VPC Endpoint for Supabase (Resources type)
resource "aws_vpc_endpoint" "supabase" {
  count = var.supabase.enabled ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = var.supabase.resource_configuration_arn
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name   = "${var.name_prefix}-supabase-privatelink"
      Type   = "Resources"
      Region = var.region
    }
  )
}
