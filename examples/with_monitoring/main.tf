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
  source   = "../.."
  location = var.location

  action_groups = merge(var.action_groups, {
    example-action-group = {
      short_name = "eala"
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
      ]
    }
  })

  # metric_alerts = merge(var.metric_alerts, {})
  metric_alerts = merge(var.metric_alerts, {
    iothub_d2c_throttling = {
      description = "Alert when D2C messages are being throttled"
      frequency   = "PT5M" # 5 minutes
      severity    = 2
      enabled     = true
      criteria = [{
        metric_namespace = "Microsoft.Devices/IotHubs"
        metric_name      = "d2c.telemetry.egress.dropped"
        aggregation      = "Total"
        operator         = "GreaterThan"
        threshold        = 100
        dimensions = [{
          name     = "IotHubName"
          operator = "Include"
          values   = ["*"]
        }]
      }]
    },
    iothub_connected_devices = {
      description = "Alert on connected device count changes"
      frequency   = "PT15M" # 15 minutes
      severity    = 3
      enabled     = true
      criteria    = []
      dynamic_criteria = {
        metric_namespace  = "Microsoft.Devices/IotHubs"
        metric_name       = "devices.totalConnected"
        aggregation       = "Average"
        operator          = "GreaterOrLessThan"
        alert_sensitivity = "Medium"
        dimensions = [{
          name     = "IotHubName"
          operator = "Include"
          values   = ["*"]
        }]
      }
    }
  })

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
