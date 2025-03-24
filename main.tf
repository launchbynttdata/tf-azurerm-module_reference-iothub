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

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = var.location
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  maximum_length          = each.value.max_length
  instance_resource       = var.instance_resource
}

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = module.resource_names["resource_group"].standard
  location = var.location

  tags = merge(var.tags, { resource_name = module.resource_names["resource_group"].standard })
}

module "iothub" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/iothub/azurerm"
  version = "~> 1.0"

  name                = module.resource_names["iothub"].standard
  location            = var.location
  resource_group_name = module.resource_names["resource_group"].standard

  sku                           = var.iothub_sku
  local_authentication_enabled  = var.local_authentication_enabled
  event_hub_partition_count     = var.event_hub_partition_count
  event_hub_retention_in_days   = var.event_hub_retention_in_days
  public_network_access_enabled = var.iothub_public_network_access_enabled
  endpoints                     = var.endpoints
  fallback_route                = var.fallback_route
  file_uploads                  = var.file_uploads
  identity                      = var.identity
  network_rule_set              = var.network_rule_set
  routes                        = var.routes
  enrichments                   = var.enrichments
  cloud_to_device               = var.cloud_to_device
  consumer_groups               = var.consumer_groups
  tags                          = local.tags
  depends_on                    = [module.resource_group]
}

module "iothub_dps" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/iothub_dps/azurerm"
  version = "~> 1.0"

  name                = module.resource_names["device_provisioning_service"].standard
  location            = var.location
  resource_group_name = module.resource_names["resource_group"].standard

  allocation_policy             = var.allocation_policy
  data_residency_enabled        = var.data_residency_enabled
  public_network_access_enabled = var.iothub_dps_public_network_access_enabled
  sku                           = var.dps_sku
  linked_hubs                   = var.linked_hubs
  ip_filter_rules               = var.ip_filter_rules
  tags                          = local.tags
  depends_on                    = [module.resource_group]
}
