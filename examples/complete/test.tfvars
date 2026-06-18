# empty
min_tls_version                                  = "1.2"
public_network_access_enabled                    = true
eventhub_namespace_public_network_access_enabled = true

eventhub_namespace_network_rule_set = {
  default_action                 = "Allow"
  trusted_service_access_enabled = true
  ip_rules                       = []
  virtual_network_rules          = []
}

create_eventhub_namespace_private_endpoint = false
