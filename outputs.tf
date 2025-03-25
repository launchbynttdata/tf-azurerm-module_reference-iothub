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

output "resource_group_name" {
  description = "The resource group for the reference Iot Hub."
  value       = module.resource_names["resource_group"].standard
}

output "iothub_id" {
  description = "The IoT Hub Id."
  value       = module.iothub.id
}

output "iothub_name" {
  description = "The IoT Hub Name."
  value       = module.iothub.name
}

output "iothub_dps_id" {
  description = "The IoT Hub Device Provisioning Service Id."
  value       = module.iothub_dps.id
}

output "iothub_dps_name" {
  description = "The IoT Hub Device Provisioning Service Name."
  value       = module.iothub_dps.name
}

output "scope_id" {
  description = "The IoT Hub Device Provisioning Service Scope Id."
  value       = module.iothub_dps.id_scope
}
