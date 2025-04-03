# tf-azurerm-module_reference_iothub

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iothub"></a> [iothub](#module\_iothub) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. | `string` | `"eastus"` | no |
| <a name="input_action_group"></a> [action\_group](#input\_action\_group) | Monitor Action Group Properties | <pre>object({<br/>    name       = string<br/>    short_name = string<br/>    arm_role_receivers = optional(list(object({<br/>      name                    = string<br/>      role_id                 = string<br/>      use_common_alert_schema = optional(bool)<br/>    })), [])<br/>    email_receivers = optional(list(object({<br/>      name                    = string<br/>      email_address           = string<br/>      use_common_alert_schema = optional(bool)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_metric_alerts"></a> [metric\_alerts](#input\_metric\_alerts) | Monitor Metric Alert Properties | <pre>map(object({<br/>    description        = optional(string)<br/>    frequency          = optional(string)<br/>    severity           = optional(number)<br/>    enabled            = optional(bool)<br/>    webhook_properties = optional(map(string))<br/>    criteria = optional(list(object({<br/>      metric_namespace       = string<br/>      metric_name            = string<br/>      aggregation            = string<br/>      operator               = string<br/>      threshold              = number<br/>      skip_metric_validation = optional(bool, false)<br/>      dimensions = optional(list(object({<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      })), [])<br/>    })))<br/>    dynamic_criteria = optional(object({<br/>      metric_namespace       = string<br/>      metric_name            = string<br/>      aggregation            = string<br/>      operator               = string<br/>      alert_sensitivity      = string<br/>      ignore_data_before     = optional(string)<br/>      skip_metric_validation = optional(bool, false)<br/>      dimensions = optional(list(object({<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      })), [])<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | n/a | <pre>map(object({<br/>    enabled_log = optional(list(object({<br/>      category_group = optional(string, "allLogs")<br/>      category       = optional(string, null)<br/>    })))<br/>    metric = optional(object({<br/>      category = optional(string)<br/>      enabled  = optional(bool)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | n/a | <pre>map(object({<br/>    sku               = string<br/>    retention_in_days = number<br/>    daily_quota_gb    = number<br/>    identity = optional(object({<br/>      type         = string<br/>      identity_ids = optional(list(string))<br/>    }))<br/>    local_authentication_disabled = optional(bool)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group of the reference IoT Hub. |
| <a name="output_iothub_id"></a> [iothub\_id](#output\_iothub\_id) | The IoT Hub Id. |
| <a name="output_iothub_name"></a> [iothub\_name](#output\_iothub\_name) | The IoT Hub Name. |
| <a name="output_iothub_dps_id"></a> [iothub\_dps\_id](#output\_iothub\_dps\_id) | The IoT Hub Device Provisioning Service Id. |
| <a name="output_iothub_dps_name"></a> [iothub\_dps\_name](#output\_iothub\_dps\_name) | The IoT Hub Device Provisioning Service Name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
