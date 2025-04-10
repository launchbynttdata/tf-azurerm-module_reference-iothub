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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group of the reference IoT Hub. |
| <a name="output_iothub_id"></a> [iothub\_id](#output\_iothub\_id) | The IoT Hub Id. |
| <a name="output_iothub_name"></a> [iothub\_name](#output\_iothub\_name) | The IoT Hub Name. |
| <a name="output_iothub_dps_id"></a> [iothub\_dps\_id](#output\_iothub\_dps\_id) | The IoT Hub Device Provisioning Service Id. |
| <a name="output_iothub_dps_name"></a> [iothub\_dps\_name](#output\_iothub\_dps\_name) | The IoT Hub Device Provisioning Service Name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
