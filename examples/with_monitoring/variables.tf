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

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    resource_group = {
      name       = "rg"
      max_length = 80
    }
    iothub = {
      name       = "iothub"
      max_length = 80
    }
    device_provisioning_service = {
      name       = "dps"
      max_length = 80
    }
  }
}

# module resource_names properties
variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  default     = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  default     = "iot"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  default     = "dev"
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
    metrics = optional(list(object({
      category = string
      enabled  = optional(bool)
    })))
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
