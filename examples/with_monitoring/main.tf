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
  source        = "../.."
  location      = var.location
  metric_alerts = merge(var.metric_alerts, {})
  # metric_alerts = {
  #   "some-metric-alert" = {}
  #     scopes = [module.iothub.xid]
  #     # description = "Some description"
  #     # frequency   = 5
  #     # severity    = 3
  #     # enabled     = true
  #     action_group_ids = "fdsafs"
  #     # webhook_properties = {
  #     #   use_common_alert_schema = true
  #     # }
  #     # criteria = [
  #     #   {
  #     #     metric_namespace       = "Microsoft.Devices/IotHubs"
  #     #     metric_name            = "d2cTelemetryMessages"
  #     #     aggregation            = "Total"
  #     #     operator               = "GreaterThan"
  #     #     threshold              = 500
  #     #     skip_metric_validation = false
  #     #   }
  #     # ]
  # }

  # log_analytics_workspace = {}
  log_analytics_workspace = merge(var.log_analytics_workspace, {
    default = {
      sku                           = "PerGB2018"
      retention_in_days             = 30
      daily_quota_gb                = 10
      identity                      = null
      local_authentication_disabled = false
    }
  })

  # diagnostic_settings = {}
  diagnostic_settings = merge(var.diagnostic_settings, {
    diagnostic_setting1 = {
      enabled_log = [
        {
          category_group = "allLogs"
          category       = "DeviceTelemetry"
        },
        {
          category_group = "allLogs"
          category       = "Operations"
        }
      ]
      metric = {
        category = "IoTHubMetrics"
        enabled  = true
      }
    }
  })
}
