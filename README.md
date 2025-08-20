# AWS PrivateLink Terraform Module

This Terraform module creates AWS PrivateLink endpoints for connecting to external services (Datadog, Temporal, or Supabase) privately within your VPC.

## Features

- **Single Service Selection**: Choose one service provider (Datadog, Temporal, or Supabase) per module instance
- **Automatic DNS Configuration**: All endpoints have private DNS enabled for seamless connectivity
- **Cross-Region Support**: Datadog supports cross-region connectivity when needed
- **Regional Validation**: Ensures services are deployed in supported regions
- **Simplified Outputs**: Clean interface for accessing endpoint DNS names

## Supported Services

### Datadog
- **Regions**: us-east-1, ap-northeast-1, ap-southeast-2
- **Endpoints**: Up to 10 different service endpoints (logs, metrics, API, traces, etc.)
- **Cross-Region**: Supported (can connect to Datadog in a different region)

### Temporal
- **Regions**: 14 regions globally (us-east-1, us-west-2, eu-west-1, etc.)
- **Endpoints**: Single endpoint for workflow orchestration
- **Cross-Region**: Not supported (must match specified region)

### Supabase
- **Regions**: Any region (requires VPC Lattice Resource Configuration ARN)
- **Endpoints**: Single endpoint for PostgreSQL database access
- **Cross-Region**: Not applicable

## Usage

### Basic Example - Datadog

```hcl
module "datadog_privatelink" {
  source = "./aws-privatelink"
  
  region            = "us-west-2"
  vpc_id            = "vpc-123456"
  subnet_ids        = ["subnet-abc", "subnet-def"]
  security_group_id = "sg-123456"
  
  datadog = {
    enabled = true
    # Optional: specify endpoints (defaults to all)
    endpoints = ["logs_agent", "metrics", "api"]
    # Optional: override region if not in a supported Datadog region
    region_override = "us-east-1"
  }
}

# Access DNS names
output "datadog_logs_dns" {
  value = module.datadog_privatelink.endpoints.logs_agent.dns_name
}
```

### Basic Example - Temporal

```hcl
module "temporal_privatelink" {
  source = "./aws-privatelink"
  
  region            = "us-west-2"
  vpc_id            = "vpc-123456"
  subnet_ids        = ["subnet-abc", "subnet-def"]
  security_group_id = "sg-123456"
  
  temporal = {
    enabled = true
  }
}

# Access DNS name
output "temporal_dns" {
  value = module.temporal_privatelink.endpoint.dns_name
}
```

### Basic Example - Supabase

```hcl
module "supabase_privatelink" {
  source = "./aws-privatelink"
  
  region            = "us-west-2"
  vpc_id            = "vpc-123456"
  subnet_ids        = ["subnet-abc", "subnet-def"]
  security_group_id = "sg-123456"
  
  supabase = {
    enabled = true
    resource_configuration_arn = "arn:aws:vpc-lattice:us-west-2:123456789012:resourceconfiguration/rc-xxxxx"
  }
}

# Access DNS name
output "supabase_dns" {
  value = module.supabase_privatelink.endpoint.dns_name
}
```

## Requirements

### Network Requirements

- **VPC**: The VPC where endpoints will be created
- **Subnets**: 
  - Must be private subnets (recommended)
  - Should span multiple Availability Zones for high availability
  - Each subnet needs at least one available IP address
- **Security Group**: Must allow appropriate inbound traffic:
  - Datadog: Port 443 (HTTPS)
  - Temporal: Port 7233 (gRPC)
  - Supabase: Port 5432 (PostgreSQL)

### Provider Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `region` | AWS region where the resources are located | `string` | Yes |
| `vpc_id` | VPC ID where endpoints will be created | `string` | Yes |
| `subnet_ids` | List of subnet IDs for endpoint placement | `list(string)` | Yes |
| `security_group_id` | Security group ID to attach to endpoints | `string` | Yes |
| `datadog` | Datadog configuration (see below) | `object` | No |
| `temporal` | Temporal configuration (see below) | `object` | No |
| `supabase` | Supabase configuration (see below) | `object` | No |
| `name_prefix` | Prefix for resource names | `string` | No |
| `tags` | Tags to apply to all resources | `map(string)` | No |

### Service Configuration Objects

#### Datadog Configuration
```hcl
datadog = {
  enabled         = bool                # Enable Datadog endpoints
  endpoints       = list(string)        # Optional: specific endpoints (defaults to all)
  region_override = string              # Optional: override region if not in a supported Datadog region
}
```

Available endpoints: `logs_agent`, `logs_user`, `api`, `metrics`, `containers`, `process`, `profiling`, `traces`, `database_monitoring`, `remote_configuration`

#### Temporal Configuration
```hcl
temporal = {
  enabled = bool  # Enable Temporal endpoint
}
```

#### Supabase Configuration
```hcl
supabase = {
  enabled                    = bool    # Enable Supabase endpoint
  resource_configuration_arn = string  # VPC Lattice Resource Configuration ARN
}
```

## Outputs

| Name | Description | Type |
|------|-------------|------|
| `endpoints` | Map of Datadog endpoints with DNS names | `map(object)` |
| `endpoint` | Single endpoint details for Temporal or Supabase | `object` |

## Validation Rules

1. **Exactly one service must be enabled** - Cannot enable multiple services in the same module instance
2. **Region compatibility**:
   - Datadog: Region must be supported or provide `region_override`
   - Temporal: Region must be a supported Temporal region
   - Supabase: No region restrictions
3. **Required configurations**:
   - Datadog: At least one endpoint must be specified or defaults to all
   - Supabase: `resource_configuration_arn` is required when enabled

## Important Notes

### Cross-Region Connectivity

- **Datadog**: Automatically detects when cross-region is needed based on region and region_override
- **Temporal**: Does not support cross-region; endpoint must be in the same region as specified
- **Supabase**: Uses VPC Lattice Resource Configuration specific to your setup

### DNS Resolution

All endpoints have private DNS enabled by default. Ensure your VPC has:
- DNS resolution enabled
- DNS hostnames enabled

### High Availability

For production environments, always:
- Use subnets from multiple Availability Zones
- Ensure your security group rules are properly configured
- Monitor endpoint health and connectivity

## Examples

### Multi-Region Datadog Setup

If your resources are in `eu-west-1` but Datadog PrivateLink is only available in specific regions:

```hcl
module "datadog_privatelink" {
  source = "./aws-privatelink"
  
  region            = "eu-west-1"
  vpc_id            = "vpc-123456"
  subnet_ids        = ["subnet-abc", "subnet-def"]
  security_group_id = "sg-123456"
  
  datadog = {
    enabled         = true
    region_override = "us-east-1"  # Connect to Datadog in us-east-1
  }
}
```

### Selective Datadog Endpoints

To create only specific Datadog endpoints instead of all:

```hcl
module "datadog_privatelink" {
  source = "./aws-privatelink"
  
  region            = "us-east-1"
  vpc_id            = "vpc-123456"
  subnet_ids        = ["subnet-abc", "subnet-def"]
  security_group_id = "sg-123456"
  
  datadog = {
    enabled   = true
    endpoints = ["logs_agent", "metrics"]  # Only create these two
  }
}
```

## Troubleshooting

### Common Issues

1. **"Service provider must be enabled"**: Ensure exactly one of `datadog.enabled`, `temporal.enabled`, or `supabase.enabled` is set to `true`

2. **"Region not supported"**: 
   - For Datadog: Use `region_override` to specify a supported region
   - For Temporal: Ensure your region is supported

3. **"Connection timeout"**: 
   - Verify security group allows traffic on the correct port
   - Ensure subnets have route tables configured correctly
   - Check that DNS resolution is working in your VPC

4. **"Resource Configuration not found"** (Supabase):
   - Ensure you've accepted the VPC Lattice Resource Share from Supabase
   - Verify the ARN is correct and in the same region

## License

[Your license here]

## Support

For issues or questions, please [create an issue](link-to-issues) in the repository.