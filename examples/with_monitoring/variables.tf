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

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
  default     = "eastus"
}

# Monitor Action Group Properties
variable "action_group" {
  type = object({
    name       = string
    short_name = string
    arm_role_receivers = optional(list(object({
      name                    = string
      role_id                 = string
      use_common_alert_schema = optional(bool)
    })), [])
    email_receivers = optional(list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool)
    })), [])
  })
  default = null
}

# Monitor Metric Alert Properties
variable "metric_alerts" {
  type = map(object({
    description        = optional(string)
    frequency          = optional(string)
    severity           = optional(number)
    enabled            = optional(bool)
    webhook_properties = optional(map(string))
    criteria = optional(list(object({
      metric_namespace       = string
      metric_name            = string
      aggregation            = string
      operator               = string
      threshold              = number
      skip_metric_validation = optional(bool, false)
      dimensions = optional(list(object({
        name     = string
        operator = string
        values   = list(string)
      })), [])
    })))
    dynamic_criteria = optional(object({
      metric_namespace       = string
      metric_name            = string
      aggregation            = string
      operator               = string
      alert_sensitivity      = string
      ignore_data_before     = optional(string)
      skip_metric_validation = optional(bool, false)
      dimensions = optional(list(object({
        name     = string
        operator = string
        values   = list(string)
      })), [])
    }))
  }))
  default = {}
}

variable "diagnostic_settings" {
  type = map(object({
    enabled_log = optional(list(object({
      category_group = optional(string, "allLogs")
      category       = optional(string, null)
    })))
    metric = optional(object({
      category = optional(string)
      enabled  = optional(bool)
    }))
  }))
  default = {}
}

variable "log_analytics_workspace" {
  type = map(object({
    sku               = string
    retention_in_days = number
    daily_quota_gb    = number
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    local_authentication_disabled = optional(bool)
  }))
  default = {}
}
