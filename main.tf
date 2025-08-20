# VPC Endpoints for Datadog (multiple endpoints)
# Datadog always uses DNS and supports cross-region
resource "aws_vpc_endpoint" "datadog" {
  for_each = local.datadog_endpoints_to_create

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = true  # Always true for Datadog

  tags = merge(
    local.common_tags,
    {
      Name         = "${var.name_prefix}-datadog-privatelink-${each.key}"
      EndpointType = each.key
      Description  = each.value.description
      Region       = local.datadog_target_region
      CrossRegion  = local.datadog_target_region != var.cluster_region ? "true" : "false"
    }
  )
  
  lifecycle {
    precondition {
      condition     = local.datadog_region_valid
      error_message = var.datadog.region_override == null && !contains(local.datadog_supported_regions, var.cluster_region) ? 
        "Your cluster is in ${var.cluster_region}, which is not a supported Datadog region. Please provide region_override with one of: ${join(", ", local.datadog_supported_regions)}" :
        "Datadog endpoints can only be created in ${join(", ", local.datadog_supported_regions)}. Current target region: ${local.datadog_target_region}"
    }
  }
}

# VPC Endpoint for Temporal (single endpoint)
# Must be in same region as cluster, no cross-region support
resource "aws_vpc_endpoint" "temporal" {
  count = var.temporal.enabled && local.temporal_service_name != "" ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = local.temporal_service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.security_group_id]
  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name   = "${var.name_prefix}-temporal-privatelink"
      Region = var.cluster_region
    }
  )
  
  lifecycle {
    precondition { condition     = contains(local.temporal_supported_regions, var.cluster_region)
      error_message = "Temporal PrivateLink is not available in region ${var.cluster_region}. Supported regions: ${join(", ", local.temporal_supported_regions)}"
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
  private_dns_enabled = true  # Always true for Supabase

  tags = merge(
    local.common_tags,
    {
      Name   = "${var.name_prefix}-supabase-privatelink"
      Type   = "Resources"
      Region = var.cluster_region
    }
  )
}
