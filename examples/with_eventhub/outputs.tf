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
  description = "The resource group of the reference IoT Hub."
  value       = module.iothub.resource_group_name
}

output "iothub_id" {
  description = "The IoT Hub Id."
  value       = module.iothub.iothub_id
}

output "iothub_name" {
  description = "The IoT Hub Name."
  value       = module.iothub.iothub_name
}

output "iothub_dps_id" {
  description = "The IoT Hub Device Provisioning Service Id."
  value       = module.iothub.iothub_dps_id
}

output "iothub_dps_name" {
  description = "The IoT Hub Device Provisioning Service Name."
  value       = module.iothub.iothub_dps_name
}
