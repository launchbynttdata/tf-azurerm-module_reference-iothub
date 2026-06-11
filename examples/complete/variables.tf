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

# module resource_names properties
variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 1
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
variable "min_tls_version" {
  description = "Minimum TLS version for IoTHub"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Keep IoTHub public access enabled for internet truck communications."
  type        = bool
  default     = true
}

variable "eventhub_namespace_public_network_access_enabled" {
  description = "Enable EventHub Namespace public endpoint."
  type        = bool
  default     = true
}

variable "eventhub_namespace_network_rule_set" {
  description = "EventHub Namespace network rule set. Default keeps public access enabled with Allow."
  type = object({
    default_action                 = optional(string, "Allow")
    trusted_service_access_enabled = optional(bool, true)
    ip_rules = optional(list(object({
      ip_mask = string
      action  = optional(string, "Allow")
    })), [])
    virtual_network_rules = optional(list(object({
      subnet_id                                       = string
      ignore_missing_virtual_network_service_endpoint = optional(bool, false)
    })), [])
  })
  default = {
    default_action                 = "Allow"
    trusted_service_access_enabled = true
    ip_rules                       = []
    virtual_network_rules          = []
  }
}

variable "create_eventhub_namespace_private_endpoint" {
  description = "Create a private endpoint for AKS services to subscribe to EventHub Namespace."
  type        = bool
  default     = false
}

variable "eventhub_namespace_private_endpoint_subnet_id" {
  description = "Subnet resource ID for EventHub Namespace private endpoint. Required when private endpoint creation is enabled."
  type        = string
  default     = null
}

variable "eventhub_namespace_private_endpoint_private_dns_zone_group_name" {
  description = "Private DNS zone group name for EventHub Namespace private endpoint."
  type        = string
  default     = ""
}

variable "eventhub_namespace_private_endpoint_private_dns_zone_ids" {
  description = "Private DNS zone IDs for EventHub Namespace private endpoint."
  type        = list(string)
  default     = []
}

variable "eventhub_namespace_private_endpoint_is_manual_connection" {
  description = "Whether EventHub Namespace private endpoint requires manual approval."
  type        = bool
  default     = false
}

variable "eventhub_namespace_private_endpoint_subresource_names" {
  description = "Subresource names for EventHub Namespace private endpoint."
  type        = list(string)
  default     = ["namespace"]
}

variable "eventhub_namespace_private_endpoint_request_message" {
  description = "Request message for manual private endpoint approval."
  type        = string
  default     = null
}
