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

  action_group = coalesce({
    name       = "example-action-group"
    short_name = "exag"
    arm_role_receivers = [
      {
        name                    = "example-arm-role"
        role_id                 = "b24988ac-6180-42a0-ab88-20f7382dd24c"
        use_common_alert_schema = true
      }
    ]
    email_receivers = [
      {
        name                    = "example-email"
        email_address           = "example@test.com"
        use_common_alert_schema = true
      }
  ] }, var.action_group)

  metric_alerts = merge(var.metric_alerts, {
    iothub_d2c_throttling = {
      description = "Alert when D2C messages are being throttled"
      frequency   = "PT5M"
      severity    = 2
      enabled     = true
      criteria = [{
        metric_namespace = "Microsoft.Devices/IotHubs"
        metric_name      = "d2c.telemetry.egress.dropped"
        aggregation      = "Total"
        operator         = "GreaterThan"
        threshold        = 100
      }]
    },
    iothub_total_messages_used = {
      description = "Alert on Total number of messages used"
      frequency   = "PT5M"
      severity    = 3
      enabled     = true
      criteria    = []
      dynamic_criteria = {
        metric_namespace  = "Microsoft.Devices/IotHubs"
        metric_name       = "dailyMessageQuotaUsed"
        aggregation       = "Maximum"
        operator          = "GreaterOrLessThan"
        alert_sensitivity = "Medium"
      }
    }
  })

  log_analytics_workspace = try({
    sku                           = "PerGB2018"
    retention_in_days             = 30
    daily_quota_gb                = 10
    identity                      = null
    local_authentication_disabled = false
  }, var.log_analytics_workspace)

  diagnostic_settings = merge(var.diagnostic_settings, {
    diagnostic_setting1 = {
      enabled_log = [
        {
          category_group = "allLogs"
          category       = "DeviceTelemetry"
        },
        {
          category_group = "allLogs"
          category       = "Connections"
        }
      ]
      metrics = [{
        category = "AllMetrics"
        enabled  = true
      }]
    }
  })
}
