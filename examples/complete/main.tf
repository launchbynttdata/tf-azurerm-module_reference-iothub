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
module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 2.0"

  for_each = var.resource_names_map

  region                  = var.location
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.1"

  name     = local.resource_group_name
  location = var.location
  tags     = { resource_group_name = local.resource_group_name }
}

module "iothub" {
  source              = "../.."
  resource_group_name = module.resource_group.name
  location            = var.location
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
      endpoint_type = "AzureIotHub.EventHub"
      route = {
        source    = "DeviceMessages"
        condition = "true"
        enabled   = true
      }
    }
  }
}
