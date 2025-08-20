locals {
  # Datadog regional endpoint configurations
  datadog_endpoints = {
    "us-east-1" = {
      logs_agent = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-025a56b9187ac1f63"
        dns_name     = "agent-http-intake.logs.datadoghq.com"
        description  = "Logs (Agent HTTP intake)"
      }
      logs_user = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-0e36256cb6172439d"
        dns_name     = "http-intake.logs.datadoghq.com"
        description  = "Logs (User HTTP intake)"
      }
      api = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-064ea718f8d0ead77"
        dns_name     = "api.datadoghq.com"
        description  = "API"
      }
      metrics = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-09a8006e245d1e7b8"
        dns_name     = "metrics.agent.datadoghq.com"
        description  = "Metrics"
      }
      containers = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-0ad5fb9e71f85fe99"
        dns_name     = "orchestrator.datadoghq.com"
        description  = "Containers"
      }
      process = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-0ed1f789ac6b0bde1"
        dns_name     = "process.datadoghq.com"
        description  = "Process"
      }
      profiling = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-022ae36a7b2472029"
        dns_name     = "intake.profile.datadoghq.com"
        description  = "Profiling"
      }
      traces = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-0355bb1880dfa09c2"
        dns_name     = "trace.agent.datadoghq.com"
        description  = "Traces"
      }
      database_monitoring = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-0ce70d55ec4af8501"
        dns_name     = "dbm-metrics-intake.datadoghq.com"
        description  = "Database Monitoring"
      }
      remote_configuration = {
        service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-01f21309e507e3b1d"
        dns_name     = "config.datadoghq.com"
        description  = "Remote Configuration"
      }
    }
    "ap-northeast-1" = {
      logs_agent = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-03e139d1f2766685b"
        dns_name     = "agent-http-intake.logs.ap1.datadoghq.com"
        description  = "Logs (Agent HTTP intake)"
      }
      logs_user = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-08799aabff1cfd8a3"
        dns_name     = "http-intake.logs.ap1.datadoghq.com"
        description  = "Logs (User HTTP intake)"
      }
      api = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-008cd79a7a09e0a1e"
        dns_name     = "api.ap1.datadoghq.com"
        description  = "API"
      }
      metrics = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-002d904d5e69340ad"
        dns_name     = "metrics.agent.ap1.datadoghq.com"
        description  = "Metrics"
      }
      containers = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-03ffd8d552f0d957d"
        dns_name     = "orchestrator.ap1.datadoghq.com"
        description  = "Containers"
      }
      process = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-0e86b29a0dc2c8a26"
        dns_name     = "process.ap1.datadoghq.com"
        description  = "Process"
      }
      profiling = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-0d598057ecde10596"
        dns_name     = "intake.profile.ap1.datadoghq.com"
        description  = "Profiling"
      }
      traces = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-0a5d94b2e8f6e70fc"
        dns_name     = "trace.agent.ap1.datadoghq.com"
        description  = "Traces"
      }
      database_monitoring = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-0cc53180ae06bb977"
        dns_name     = "dbm-metrics-intake.ap1.datadoghq.com"
        description  = "Database Monitoring"
      }
      remote_configuration = {
        service_name = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-00e15ab206f23b98c"
        dns_name     = "config.ap1.datadoghq.com"
        description  = "Remote Configuration"
      }
    }
    "ap-southeast-2" = {
      logs_agent = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-06460db30a7cfdace"
        dns_name     = "gold.intake.ap2.datadoghq.com"
        description  = "Logs (Agent HTTP intake)"
      }
      logs_user = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-06460db30a7cfdace"
        dns_name     = "gold.intake.ap2.datadoghq.com"
        description  = "Logs (User HTTP intake)"
      }
      api = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-06ec78b291ce8020a"
        dns_name     = "orchid.intake.ap2.datadoghq.com"
        description  = "API"
      }
      metrics = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0c26ca335d93a68b5"
        dns_name     = "beige.intake.ap2.datadoghq.com"
        description  = "Metrics"
      }
      containers = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-031da3ffac78ef902"
        dns_name     = "linen.intake.ap2.datadoghq.com"
        description  = "Containers"
      }
      process = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0c26ca335d93a68b5"
        dns_name     = "bisque.intake.ap2.datadoghq.com"
        description  = "Process"
      }
      profiling = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0d936da0e6a30d3cd"
        dns_name     = "cyan.intake.ap2.datadoghq.com"
        description  = "Profiling"
      }
      traces = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0f3e01f4180b2ae09"
        dns_name     = "lime.intake.ap2.datadoghq.com"
        description  = "Traces"
      }
      database_monitoring = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-094469ee7a178f448"
        dns_name     = "white.intake.ap2.datadoghq.com"
        description  = "Database Monitoring"
      }
      remote_configuration = {
        service_name = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-01f8f80f4cb97bd10"
        dns_name     = "violet.intake.ap2.datadoghq.com"
        description  = "Remote Configuration"
      }
    }
  }
  
  # Derive Datadog supported regions from the endpoints map
  datadog_supported_regions = keys(local.datadog_endpoints)
  
  # Determine Datadog target region
  datadog_target_region = var.datadog.enabled ? (
    var.datadog.region_override != null ? var.datadog.region_override : var.cluster_region
  ) : ""
  
  # Validate Datadog region is supported
  datadog_region_valid = contains(local.datadog_supported_regions, local.datadog_target_region)
  
  # Get Datadog endpoints for the target region
  datadog_endpoints_for_region = local.datadog_region_valid && var.datadog.enabled ? (
    lookup(local.datadog_endpoints, local.datadog_target_region, {})
  ) : {}
  
  # Filter Datadog endpoints based on user selection
  datadog_endpoints_to_create = var.datadog.enabled && local.datadog_region_valid ? (
    length(var.datadog.endpoints) > 0 ? 
    { for k, v in local.datadog_endpoints_for_region : k => v if contains(var.datadog.endpoints, k) } :
    local.datadog_endpoints_for_region
  ) : {}
  
  # Temporal regional service names
  temporal_service_names = {
    "ap-northeast-1" = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-08f34c33f9fb8a48a"
    "ap-northeast-2" = "com.amazonaws.vpce.ap-northeast-2.vpce-svc-08c4d5445a5aad308"
    "ap-south-1"     = "com.amazonaws.vpce.ap-south-1.vpce-svc-0ad4f8ed56db15662"
    "ap-south-2"     = "com.amazonaws.vpce.ap-south-2.vpce-svc-08bcf602b646c69c1"
    "ap-southeast-1" = "com.amazonaws.vpce.ap-southeast-1.vpce-svc-05c24096fa89b0ccd"
    "ap-southeast-2" = "com.amazonaws.vpce.ap-southeast-2.vpce-svc-0634f9628e3c15b08"
    "ca-central-1"   = "com.amazonaws.vpce.ca-central-1.vpce-svc-080a781925d0b1d9d"
    "eu-central-1"   = "com.amazonaws.vpce.eu-central-1.vpce-svc-073a419b36663a0f3"
    "eu-west-1"      = "com.amazonaws.vpce.eu-west-1.vpce-svc-04388e89f3479b739"
    "eu-west-2"      = "com.amazonaws.vpce.eu-west-2.vpce-svc-0ac7f9f07e7fb5695"
    "sa-east-1"      = "com.amazonaws.vpce.sa-east-1.vpce-svc-0ca67a102f3ce525a"
    "us-east-1"      = "com.amazonaws.vpce.us-east-1.vpce-svc-0822256b6575ea37f"
    "us-east-2"      = "com.amazonaws.vpce.us-east-2.vpce-svc-01b8dccfc6660d9d4"
    "us-west-2"      = "com.amazonaws.vpce.us-west-2.vpce-svc-0f44b3d7302816b94"
  }
  
  # Derive Temporal supported regions from the service names map
  temporal_supported_regions = keys(local.temporal_service_names)
  
  # Get the appropriate Temporal service name (must match cluster region)
  temporal_service_name = var.temporal.enabled ? (
    lookup(local.temporal_service_names, var.cluster_region, "")
  ) : ""
  
  # Determine which service is enabled
  active_service = var.datadog.enabled ? "datadog" : (
    var.temporal.enabled ? "temporal" : (
      var.supabase.enabled ? "supabase" : "none"
    )
  )
  
  # Common tags
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "terraform"
      Service   = local.active_service
    }
  )
}