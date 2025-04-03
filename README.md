# tf-azurerm-module_reference-iothub

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

Manages Azure IoT Hub and Device Provisioning Service.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_iothub"></a> [iothub](#module\_iothub) | terraform.registry.launch.nttdata.com/module_primitive/iothub/azurerm | ~> 1.0 |
| <a name="module_iothub_dps"></a> [iothub\_dps](#module\_iothub\_dps) | terraform.registry.launch.nttdata.com/module_primitive/iothub_dps/azurerm | ~> 1.0 |
| <a name="module_eventhub_namespace"></a> [eventhub\_namespace](#module\_eventhub\_namespace) | terraform.registry.launch.nttdata.com/module_primitive/eventhub_namespace/azurerm | ~> 1.0.0 |
| <a name="module_eventhub"></a> [eventhub](#module\_eventhub) | terraform.registry.launch.nttdata.com/module_primitive/eventhub/azurerm | ~> 1.0.0 |
| <a name="module_eventhub_auth_rules"></a> [eventhub\_auth\_rules](#module\_eventhub\_auth\_rules) | git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-eventhub_authorization_rule.git//. | fix/add-output |
| <a name="module_monitor_action_group"></a> [monitor\_action\_group](#module\_monitor\_action\_group) | terraform.registry.launch.nttdata.com/module_primitive/monitor_action_group/azurerm | ~> 1.0.0 |
| <a name="module_monitor_metric_alert"></a> [monitor\_metric\_alert](#module\_monitor\_metric\_alert) | terraform.registry.launch.nttdata.com/module_primitive/monitor_metric_alert/azurerm | ~> 1.1 |
| <a name="module_log_analytics_workspace"></a> [log\_analytics\_workspace](#module\_log\_analytics\_workspace) | terraform.registry.launch.nttdata.com/module_primitive/log_analytics_workspace/azurerm | ~> 1.0 |
| <a name="module_diagnostic_setting"></a> [diagnostic\_setting](#module\_diagnostic\_setting) | terraform.registry.launch.nttdata.com/module_primitive/monitor_diagnostic_setting/azurerm | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br/>    name       = string<br/>    max_length = optional(number, 60)<br/>  }))</pre> | <pre>{<br/>  "device_provisioning_service": {<br/>    "max_length": 80,<br/>    "name": "dps"<br/>  },<br/>  "diagnostic_setting": {<br/>    "max_length": 80,<br/>    "name": "ds"<br/>  },<br/>  "eventhub_namespace": {<br/>    "max_length": 80,<br/>    "name": "evthubns"<br/>  },<br/>  "iothub": {<br/>    "max_length": 80,<br/>    "name": "iothub"<br/>  },<br/>  "log_analytics_workspace": {<br/>    "max_length": 80,<br/>    "name": "law"<br/>  },<br/>  "resource_group": {<br/>    "max_length": 80,<br/>    "name": "rg"<br/>  }<br/>}</pre> | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Is the IotHub resource accessible from a public network? Defaults to true. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | Name of the product family for which the resource is created. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | Name of the product service for which the resource is created. | `string` | `"iothub"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_use_azure_region_abbr"></a> [use\_azure\_region\_abbr](#input\_use\_azure\_region\_abbr) | Use Azure region abbreviation in resource names. | `bool` | `true` | no |
| <a name="input_local_authentication_enabled"></a> [local\_authentication\_enabled](#input\_local\_authentication\_enabled) | (Optional) Boolean flag to specify whether or not local authentication is enabled or not. Defaults to true. | `bool` | `true` | no |
| <a name="input_event_hub_partition_count"></a> [event\_hub\_partition\_count](#input\_event\_hub\_partition\_count) | (Optional) The number of device-to-cloud partitions used by backing event hubs. Must be between 2 and 128. Defaults to 4. | `number` | `4` | no |
| <a name="input_event_hub_retention_in_days"></a> [event\_hub\_retention\_in\_days](#input\_event\_hub\_retention\_in\_days) | (Optional) The event hub retention to use in days. Must be between 1 and 7. Defaults to 1. | `number` | `1` | no |
| <a name="input_iothub_sku"></a> [iothub\_sku](#input\_iothub\_sku) | (Required) The sku specified for the IoT Hub.<br/>  object({<br/>    name = (Required) The name of the sku. Possible values are B1, B2, B3, F1, S1, S2, and S3. Defaults to S1.<br/>    capacity = (Required) The number of provisioned IoT Hub units. Defaults to 1.<br/>  }) | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | <pre>{<br/>  "capacity": 1,<br/>  "name": "S1"<br/>}</pre> | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | (Optional) A map of endpoints and their respective properties."<br/>    map(object({<br/>      name (as map key)          = (Required) The name of the endpoint. The name must be unique across endpoint types. The following names are reserved: events, operationsMonitoringEvents, fileNotifications and $default.<br/>      type                       = (Required) The type of the endpoint. Possible values are AzureIotHub.StorageContainer, AzureIotHub.ServiceBusQueue, AzureIotHub.ServiceBusTopic or AzureIotHub.EventHub.<br/>      connection\_string          = (Optional) The connection string for the endpoint. This attribute is mandatory and can only be specified when authentication\_type is keyBased.<br/>      authentication\_type        = (Optional) The type used to authenticate against the endpoint. Possible values are keyBased and identityBased. Defaults to keyBased.<br/>      identity\_id                = (Optional) The ID of the User Managed Identity used to authenticate against the endpoint.<br/>      endpoint\_uri               = (Optional) URI of the Service Bus or Event Hubs Namespace endpoint. This attribute can only be specified and is mandatory when authentication\_type is identityBased for endpoint type AzureIotHub.ServiceBusQueue, AzureIotHub.ServiceBusTopic or AzureIotHub.EventHub.<br/>      entity\_path                = (Optional) Name of the Service Bus Queue/Topic or Event Hub. This attribute can only be specified and is mandatory when authentication\_type is identityBased for endpoint type AzureIotHub.ServiceBusQueue, AzureIotHub.ServiceBusTopic or AzureIotHub.EventHub.<br/>      batch\_frequency\_in\_seconds = (Optional) Time interval at which blobs are written to storage. Value should be between 60 and 720 seconds. Default value is 300 seconds. This attribute is applicable for endpoint type AzureIotHub.StorageContainer.<br/>      max\_chunk\_size\_in\_bytes    = (Optional) Maximum number of bytes for each blob written to storage. Value should be between 10485760(10MB) and 524288000(500MB). Default value is 314572800(300MB). This attribute is applicable for endpoint type AzureIotHub.StorageContainer.<br/>      container\_name             = (Optional) The name of storage container in the storage account. This attribute is mandatory for endpoint type AzureIotHub.StorageContainer.<br/>      encoding                   = (Optional) Encoding that is used to serialize messages to blobs. Supported values are Avro, AvroDeflate and JSON. Default value is Avro. This attribute is applicable for endpoint type AzureIotHub.StorageContainer. Changing this forces a new resource to be created.<br/>      file\_name\_format           = (Optional) File name format for the blob. All parameters are mandatory but can be reordered. This attribute is applicable for endpoint type AzureIotHub.StorageContainer. Defaults to {iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}.<br/>      resource\_group\_name        = (Optional) The resource group in which the endpoint will be created.<br/>    })) | <pre>map(object({<br/>    type                       = string<br/>    connection_string          = optional(string)<br/>    authentication_type        = optional(string)<br/>    identity_id                = optional(string)<br/>    endpoint_uri               = optional(string)<br/>    entity_path                = optional(string)<br/>    batch_frequency_in_seconds = optional(number)<br/>    max_chunk_size_in_bytes    = optional(number)<br/>    container_name             = optional(string)<br/>    encoding                   = optional(string)<br/>    file_name_format           = optional(string)<br/>    resource_group_name        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_fallback_route"></a> [fallback\_route](#input\_fallback\_route) | (Optional) A map of fallback route properties. The routing rule that is evaluated as a catch-all route when no other routes match.<br/>    object({<br/>      source         = (Optional) The source that the routing rule is to be applied to. Possible values include: Invalid, DeviceMessages, TwinChangeEvents, DeviceLifecycleEvents, DeviceConnectionStateEvents, DeviceJobLifecycleEvents and DigitalTwinChangeEvents. Defaults to DeviceMessages.<br/>      condition      = (Optional) The condition that is evaluated to apply the routing rule. Defaults to true. For grammar, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language.<br/>      endpoint\_names = (Optional) The endpoints to which messages that satisfy the condition are routed. Currently only 1 endpoint is allowed.<br/>      enabled        = (Optional) Used to specify whether the fallback route is enabled.<br/>    }) | <pre>object({<br/>    source         = optional(string)<br/>    condition      = optional(string)<br/>    endpoint_names = optional(list(string))<br/>    enabled        = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_file_uploads"></a> [file\_uploads](#input\_file\_uploads) | (Optional) A mapping of file upload properties.<br/>    map(object({<br/>      connection\_string   = (Required) The connection string for the Azure Storage account to which files are uploaded.<br/>      container\_name      = (Required) The name of the root container where the files should be uploaded to. The container need not exist but should be creatable using the connection\_string specified.<br/>      authentication\_type = (Optional) The type used to authenticate against the storage account. Possible values are keyBased and identityBased. Defaults to keyBased.<br/>      identity\_id         = (Optional) The ID of the User Managed Identity used to authenticate against the storage account.<br/>      sas\_ttl             = (Optional) The period of time for which the SAS URI generated by IoT Hub for file upload is valid, specified as an ISO 8601 timespan duration. This value must be between 1 minute and 24 hours. Defaults to PT1H.<br/>      notifications       = (Optional) Used to specify whether file notifications are sent to IoT Hub on upload. Defaults to false.<br/>      lock\_duration       = (Optional) The lock duration for the file upload notifications queue, specified as an ISO 8601 timespan duration. This value must be between 5 and 300 seconds. Defaults to PT1M.<br/>      default\_ttl         = (Optional) The period of time for which a file upload notification message is available to consume before it expires, specified as an ISO 8601 timespan duration. This value must be between 1 minute and 48 hours. Defaults to PT1H.<br/>      max\_delivery\_count  = (Optional) The number of times the IoT Hub attempts to deliver a file upload notification message. Defaults to 10.<br/>    })) | <pre>map(object({<br/>    connection_string   = string<br/>    container_name      = string<br/>    authentication_type = optional(string)<br/>    identity_id         = optional(string)<br/>    sas_ttl             = optional(string)<br/>    notifications       = optional(bool)<br/>    lock_duration       = optional(string)<br/>    default_ttl         = optional(string)<br/>    max_delivery_count  = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) The identity configured for the IoT Hub.<br/>    object({<br/>      identity\_type = (Optional) Specifies the type of Managed Service Identity configured on this IoT Hub.<br/>        Possible values are `SystemAssigned`, `UserAssigned`, and `SystemAssigned, UserAssigned` (to enable both). Defaults to `SystemAssigned`."<br/>      identity\_ids  = (Optional) A list of User Assigned Managed Service Identity IDs to associate with the IoT Hub. Required if `identity_type` is set to `UserAssigned`.<br/>    }) | <pre>object({<br/>    identity_type = string<br/>    identity_ids  = optional(list(string))<br/>  })</pre> | <pre>{<br/>  "identity_type": "SystemAssigned"<br/>}</pre> | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | (Optional) An object for cloud-to-device messaging properties.<br/>    object({<br/>      default\_action                     = (Optional) Default Action for Network Rule Set. Possible values are Deny, Allow. Defaults to Deny.<br/>      apply\_to\_builtin\_eventhub\_endpoint = (Optional) Determines if Network Rule Set is also applied to the BuiltIn EventHub EndPoint of the IotHub. Defaults to false.<br/>      ip\_rules = optional(map(object({<br/>        ip\_rule\_name   = (Required) The name of the IP rule.<br/>        ip\_rule\_mask   = (Required) The IP address range in CIDR notation for the IP rule.<br/>        ip\_rule\_action = (Optional) The desired action for requests captured by this rule. Possible values are Allow. Defaults to Allow.<br/>      })))<br/>    }) | <pre>object({<br/>    default_action                     = optional(string)<br/>    apply_to_builtin_eventhub_endpoint = optional(bool)<br/>    ip_rules = optional(map(object({<br/>      ip_rule_name   = string<br/>      ip_rule_mask   = string<br/>      ip_rule_action = optional(string)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | (Optional) A map of routes and their respective properties<br/>    object({<br/>      name (as map key) = (Required) The name of the route.<br/>      source            = (Required) The source that the routing rule is to be applied to, such as DeviceMessages. Possible values include: Invalid, DeviceMessages, TwinChangeEvents, DeviceLifecycleEvents, DeviceConnectionStateEvents, DeviceJobLifecycleEvents and DigitalTwinChangeEvents.<br/>      endpoint\_names    = (Required) The list of endpoints to which messages that satisfy the condition are routed.<br/>      enabled           = (Required) Used to specify whether a route is enabled.<br/>      condition         = (Optional) The condition that is evaluated to apply the routing rule. Defaults to true. For grammar, see: https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language.<br/>    }) | <pre>map(object({<br/>    source         = string<br/>    endpoint_names = list(string)<br/>    enabled        = bool<br/>    condition      = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_enrichments"></a> [enrichments](#input\_enrichments) | (Optional) A map of enrichments and their respective properties<br/>    object({<br/>      key (as map key) = (Required) The key of the enrichment.<br/>      value            = (Required) The value of the enrichment. Value can be any static string, the name of the IoT Hub sending the message (use $iothubname) or information from the device twin (ex: $twin.tags.latitude)<br/>      endpoint\_names   = (Required) The list of endpoints which will be enriched.<br/>    }) | <pre>map(object({<br/>    value          = string<br/>    endpoint_names = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_cloud_to_device"></a> [cloud\_to\_device](#input\_cloud\_to\_device) | (Optional) An object for cloud-to-device messaging properties.<br/>    object({<br/>      max\_delivery\_count = (Optional) The maximum delivery count for cloud-to-device per-device queues. This value must be between 1 and 100. Defaults to 10.<br/>      default\_ttl        = (Optional) The default time to live for cloud-to-device messages, specified as an ISO 8601 timespan duration. This value must be between 1 minute and 48 hours. Defaults to PT1H.<br/>      feedback = object({<br/>        time\_to\_live       = (Optional) The retention time for service-bound feedback messages, specified as an ISO 8601 timespan duration. This value must be between 1 minute and 48 hours. Defaults to PT1H.<br/>        max\_delivery\_count = (Optional) The maximum delivery count for the feedback queue. This value must be between 1 and 100. Defaults to 10.<br/>        lock\_duration      = (Optional) The lock duration for the feedback queue, specified as an ISO 8601 timespan duration. This value must be between 5 and 300 seconds. Defaults to PT60S.<br/>    }) | <pre>object({<br/>    max_delivery_count = number<br/>    default_ttl        = string<br/>    feedback = object({<br/>      time_to_live       = string<br/>      max_delivery_count = number<br/>      lock_duration      = string<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_consumer_groups"></a> [consumer\_groups](#input\_consumer\_groups) | (Optional) A map of consumer groups and their respective properties."<br/>    map(object({<br/>      name (as map key)      = (Required) The name of this Consumer Group.<br/>      resource\_group\_name    = (Required) The name of the resource group that contains the IoT hub.<br/>      eventhub\_endpoint\_name = (Required) The name of the Event Hub-compatible endpoint in the IoT hub.<br/>    })) | <pre>map(object({<br/>    eventhub_endpoint_name = string<br/>    resource_group_name    = string<br/>  }))</pre> | `{}` | no |
| <a name="input_allocation_policy"></a> [allocation\_policy](#input\_allocation\_policy) | (Optional) The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static). Defaults to Hashed. | `string` | `"Hashed"` | no |
| <a name="input_data_residency_enabled"></a> [data\_residency\_enabled](#input\_data\_residency\_enabled) | Optional) Specifies if the IoT Device Provisioning Service has data residency and disaster recovery enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_dps_sku"></a> [dps\_sku](#input\_dps\_sku) | (Required) The pricing tier for the IoT Device Provisioning Service.<br/>    object({<br/>      name     = (Required) The name of the sku. Currently can only be set to S1.<br/>      capacity = (Required) The number of provisioned IoT Device Provisioning Service units. Currently set to 1.<br/>    }) | <pre>object({<br/>    name     = string<br/>    capacity = number<br/>  })</pre> | <pre>{<br/>  "capacity": 1,<br/>  "name": "S1"<br/>}</pre> | no |
| <a name="input_linked_hubs"></a> [linked\_hubs](#input\_linked\_hubs) | (Optional) A list of iothub objects linked to the Device Provisioning Service. Defaults to an empty list `[]`.<br/>  list(object({<br/>    connection\_string       = (Required) The connection string to connect to the IoT Hub.<br/>    location                = (Required) The location of the IoT hub.<br/>    apply\_allocation\_policy = (Optional) Determines whether to apply allocation policies to the IoT Hub. Defaults to true.<br/>    allocation\_weight       = (Optional) The weight applied to the IoT Hub. Defaults to 1.<br/>  })) | <pre>list(object({<br/>    connection_string       = string<br/>    location                = string<br/>    apply_allocation_policy = optional(bool)<br/>    allocation_weight       = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_ip_filter_rules"></a> [ip\_filter\_rules](#input\_ip\_filter\_rules) | (Optional) A list of ip\_filter\_rule objects. Defaults to an empty list `[]`.<br/>  list(object({<br/>    name    = (Required) The name of the filter.<br/>    ip\_mask = (Required) The IP address range in CIDR notation for the rule.<br/>    action  = (Required) The desired action for requests captured by this rule. Possible values are Accept, Reject<br/>    target  = (Optional) Target for requests captured by this rule. Possible values are all, deviceApi and serviceApi.<br/>  })) | <pre>list(object({<br/>    name    = string<br/>    ip_mask = string<br/>    action  = string<br/>    target  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_eventhub_namespace_sku"></a> [eventhub\_namespace\_sku](#input\_eventhub\_namespace\_sku) | The sku for the eventhub namespace. Possible values: Basic, Standard, Premium | `string` | `"Standard"` | no |
| <a name="input_eventhub_namespace_capacity"></a> [eventhub\_namespace\_capacity](#input\_eventhub\_namespace\_capacity) | The capacity of the Event Hub Namespace:<br/>  - Basic: 1<br/>  - Standard: Between 1 and 20<br/>  - Premium: Between 1 and 4 | `number` | `1` | no |
| <a name="input_eventhubs"></a> [eventhubs](#input\_eventhubs) | A map of event hubs | <pre>map(object({<br/>    partition_count   = optional(number)<br/>    message_retention = optional(number)<br/>    status            = optional(string)<br/>    capture_description = optional(object({<br/>      enabled             = bool<br/>      encoding            = string<br/>      interval_in_seconds = number<br/>      size_limit_in_bytes = number<br/>      destination = object({<br/>        name                = string<br/>        blob_container_name = string<br/>        archive_name_format = string<br/>        storage_account_id  = string<br/>      })<br/>    }))<br/>    auth_rules = optional(object({<br/>      listen = optional(bool, false)<br/>      send   = optional(bool, false)<br/>      manage = optional(bool, false)<br/>    }))<br/>    # iothub custom endpoint<br/>    endpoint_type = optional(string)<br/>    # iothub route<br/>    route = optional(object({<br/>      endpoint_name = optional(list(string))<br/>      source        = optional(string, "DeviceMessages")<br/>      condition     = optional(string)<br/>      enabled       = optional(bool, true)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_action_group"></a> [action\_group](#input\_action\_group) | An action group object. Each action group can have:<br/>  - short\_name: (Required) The short name of the action group<br/>  - arm\_role\_receivers: (Optional) List of ARM role receivers<br/>  - email\_receivers: (Optional) List of email receivers | <pre>object({<br/>    name       = string<br/>    short_name = string<br/>    arm_role_receivers = optional(list(object({<br/>      name                    = string<br/>      role_id                 = string<br/>      use_common_alert_schema = optional(bool)<br/>    })), [])<br/>    email_receivers = optional(list(object({<br/>      name                    = string<br/>      email_address           = string<br/>      use_common_alert_schema = optional(bool)<br/>    })), [])<br/>  })</pre> | `null` | no |
| <a name="input_metric_alerts"></a> [metric\_alerts](#input\_metric\_alerts) | Monitor Metric Alert Properties | <pre>map(object({<br/>    # scopes             = list(string)<br/>    description = optional(string)<br/>    frequency   = optional(string)<br/>    severity    = optional(number)<br/>    enabled     = optional(bool)<br/>    # action_group_ids   = string<br/>    webhook_properties = optional(map(string))<br/>    criteria = optional(list(object({<br/>      metric_namespace       = string<br/>      metric_name            = string<br/>      aggregation            = string<br/>      operator               = string<br/>      threshold              = number<br/>      skip_metric_validation = optional(bool, false)<br/>      dimensions = optional(list(object({<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      })), [])<br/>    })))<br/>    dynamic_criteria = optional(object({<br/>      metric_namespace       = string<br/>      metric_name            = string<br/>      aggregation            = string<br/>      operator               = string<br/>      alert_sensitivity      = string<br/>      ignore_data_before     = optional(string)<br/>      skip_metric_validation = optional(bool, false)<br/>      dimensions = optional(list(object({<br/>        name     = string<br/>        operator = string<br/>        values   = list(string)<br/>      })), [])<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | n/a | <pre>map(object({<br/>    enabled_log = optional(list(object({<br/>      category_group = optional(string, "allLogs")<br/>      category       = optional(string, null)<br/>    })))<br/>    metric = optional(object({<br/>      category = optional(string)<br/>      enabled  = optional(bool)<br/>    }))<br/>    # log_analytics_destination_type = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | n/a | <pre>object({<br/>    sku               = string<br/>    retention_in_days = number<br/>    daily_quota_gb    = number<br/>    identity = optional(object({<br/>      type         = string<br/>      identity_ids = optional(list(string))<br/>    }))<br/>    local_authentication_disabled = optional(bool)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group for the reference Iot Hub. |
| <a name="output_iothub_id"></a> [iothub\_id](#output\_iothub\_id) | The IoT Hub Id. |
| <a name="output_iothub_name"></a> [iothub\_name](#output\_iothub\_name) | The IoT Hub Name. |
| <a name="output_iothub_dps_id"></a> [iothub\_dps\_id](#output\_iothub\_dps\_id) | The IoT Hub Device Provisioning Service Id. |
| <a name="output_iothub_dps_name"></a> [iothub\_dps\_name](#output\_iothub\_dps\_name) | The IoT Hub Device Provisioning Service Name. |
| <a name="output_scope_id"></a> [scope\_id](#output\_scope\_id) | The IoT Hub Device Provisioning Service Scope Id. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
