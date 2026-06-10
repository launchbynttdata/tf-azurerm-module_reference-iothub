# tf-azurerm-module_reference_iothub

<!-- BEGIN_TF_DOCS -->
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
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `1` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br/>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br/>    For example, backend, frontend, middleware etc. | `string` | `"iot"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | Minimum TLS version for IoTHub | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Keep IoTHub public access enabled for internet truck communications. | `bool` | `true` | no |
| <a name="input_eventhub_namespace_public_network_access_enabled"></a> [eventhub\_namespace\_public\_network\_access\_enabled](#input\_eventhub\_namespace\_public\_network\_access\_enabled) | Enable EventHub Namespace public endpoint while enforcing restrictive network rules. | `bool` | `true` | no |
| <a name="input_eventhub_namespace_network_rule_set"></a> [eventhub\_namespace\_network\_rule\_set](#input\_eventhub\_namespace\_network\_rule\_set) | Restrict EventHub Namespace public access to trusted Azure services only. | <pre>object({<br/>    default_action                 = optional(string, "Deny")<br/>    trusted_service_access_enabled = optional(bool, true)<br/>    ip_rules = optional(list(object({<br/>      ip_mask = string<br/>      action  = optional(string, "Allow")<br/>    })), [])<br/>    virtual_network_rules = optional(list(object({<br/>      subnet_id                                       = string<br/>      ignore_missing_virtual_network_service_endpoint = optional(bool, false)<br/>    })), [])<br/>  })</pre> | <pre>{<br/>  "default_action": "Deny",<br/>  "ip_rules": [],<br/>  "trusted_service_access_enabled": true,<br/>  "virtual_network_rules": []<br/>}</pre> | no |
| <a name="input_create_eventhub_namespace_private_endpoint"></a> [create\_eventhub\_namespace\_private\_endpoint](#input\_create\_eventhub\_namespace\_private\_endpoint) | Create a private endpoint for AKS services to subscribe to EventHub Namespace. | `bool` | `false` | no |
| <a name="input_eventhub_namespace_private_endpoint_subnet_id"></a> [eventhub\_namespace\_private\_endpoint\_subnet\_id](#input\_eventhub\_namespace\_private\_endpoint\_subnet\_id) | Subnet resource ID for EventHub Namespace private endpoint. Required when private endpoint creation is enabled. | `string` | `null` | no |
| <a name="input_eventhub_namespace_private_endpoint_private_dns_zone_group_name"></a> [eventhub\_namespace\_private\_endpoint\_private\_dns\_zone\_group\_name](#input\_eventhub\_namespace\_private\_endpoint\_private\_dns\_zone\_group\_name) | Private DNS zone group name for EventHub Namespace private endpoint. | `string` | `null` | no |
| <a name="input_eventhub_namespace_private_endpoint_private_dns_zone_ids"></a> [eventhub\_namespace\_private\_endpoint\_private\_dns\_zone\_ids](#input\_eventhub\_namespace\_private\_endpoint\_private\_dns\_zone\_ids) | Private DNS zone IDs for EventHub Namespace private endpoint. | `list(string)` | `[]` | no |
| <a name="input_eventhub_namespace_private_endpoint_is_manual_connection"></a> [eventhub\_namespace\_private\_endpoint\_is\_manual\_connection](#input\_eventhub\_namespace\_private\_endpoint\_is\_manual\_connection) | Whether EventHub Namespace private endpoint requires manual approval. | `bool` | `false` | no |
| <a name="input_eventhub_namespace_private_endpoint_subresource_names"></a> [eventhub\_namespace\_private\_endpoint\_subresource\_names](#input\_eventhub\_namespace\_private\_endpoint\_subresource\_names) | Subresource names for EventHub Namespace private endpoint. | `list(string)` | <pre>[<br/>  "namespace"<br/>]</pre> | no |
| <a name="input_eventhub_namespace_private_endpoint_request_message"></a> [eventhub\_namespace\_private\_endpoint\_request\_message](#input\_eventhub\_namespace\_private\_endpoint\_request\_message) | Request message for manual private endpoint approval. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group of the reference IoT Hub. |
| <a name="output_iothub_id"></a> [iothub\_id](#output\_iothub\_id) | The IoT Hub Id. |
| <a name="output_iothub_name"></a> [iothub\_name](#output\_iothub\_name) | The IoT Hub Name. |
| <a name="output_iothub_dps_id"></a> [iothub\_dps\_id](#output\_iothub\_dps\_id) | The IoT Hub Device Provisioning Service Id. |
| <a name="output_iothub_dps_name"></a> [iothub\_dps\_name](#output\_iothub\_dps\_name) | The IoT Hub Device Provisioning Service Name. |
<!-- END_TF_DOCS -->
