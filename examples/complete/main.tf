// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "iothub" {
  source = "../.."

  location                = var.location
  class_env               = var.class_env
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service

  public_network_access_enabled                                   = var.public_network_access_enabled
  eventhub_namespace_public_network_access_enabled                = var.eventhub_namespace_public_network_access_enabled
  eventhub_namespace_network_rule_set                             = var.eventhub_namespace_network_rule_set
  create_eventhub_namespace_private_endpoint                      = var.create_eventhub_namespace_private_endpoint
  eventhub_namespace_private_endpoint_subnet_id                   = var.eventhub_namespace_private_endpoint_subnet_id
  eventhub_namespace_private_endpoint_private_dns_zone_group_name = var.eventhub_namespace_private_endpoint_private_dns_zone_group_name
  eventhub_namespace_private_endpoint_private_dns_zone_ids        = var.eventhub_namespace_private_endpoint_private_dns_zone_ids
  eventhub_namespace_private_endpoint_is_manual_connection        = var.eventhub_namespace_private_endpoint_is_manual_connection
  eventhub_namespace_private_endpoint_subresource_names           = var.eventhub_namespace_private_endpoint_subresource_names
  eventhub_namespace_private_endpoint_request_message             = var.eventhub_namespace_private_endpoint_request_message
  create_iothub_private_endpoint                                  = var.create_iothub_private_endpoint
  iothub_private_endpoint_subnet_id                               = var.iothub_private_endpoint_subnet_id
  iothub_private_endpoint_private_dns_zone_group_name             = var.iothub_private_endpoint_private_dns_zone_group_name
  iothub_private_endpoint_private_dns_zone_ids                    = var.iothub_private_endpoint_private_dns_zone_ids
  iothub_private_endpoint_is_manual_connection                    = var.iothub_private_endpoint_is_manual_connection
  iothub_private_endpoint_subresource_names                       = var.iothub_private_endpoint_subresource_names
  iothub_private_endpoint_request_message                         = var.iothub_private_endpoint_request_message

  min_tls_version = var.min_tls_version
  eventhubs = {
    eventhub1 = {
      partition_count   = 2
      message_retention = 1
      status            = "Active"
      auth_rules = {
        listen = true
        send   = true
        manage = false
      }
      endpoint_type       = "AzureIotHub.EventHub"
      authentication_type = "identityBased"
      route = {
        source    = "DeviceMessages"
        condition = "true"
        enabled   = true
      }
    }
  }
}
