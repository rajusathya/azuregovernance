variable "sProject01id" {
  description = "The subscription id for Project 01 Subscription"
  default     = null
}

data "azurerm_subscription" "sProject01" {
  subscription_id = var.sProject01id[var.deploymentStage]
}

resource "azuread_group" "gProject01Support" {
  name = "Project 01 Support"
}

resource "random_uuid" "uuidProject01CustomSupportAssignment" {}

resource "azurerm_role_assignment" "assProject01CustomSupportAssignment" {
  name               = "$random_uuid.uuidProject01CustomSupportAssignment.result"
  scope              = "$azurerm_subscription.sProject01.subscription_id"
  role_definition_id = "$azurerm_role_definition.roleCustomSupport.id"
  principal_id       = "$azuread_group.gProject01Support.id"
}

#TODO: Add Policy Definition/Assignment

# resource "azurerm_security_center_contact" "example" {
#   email = "contact@example.com"
#   phone = "+1-555-555-5555"

#   alert_notifications = true
#   alerts_to_admins    = true
# }

# resource "azurerm_security_center_subscription_pricing" "example" {
#   tier = "Standard"
# }

# resource "azurerm_resource_group" "example" {
#   name     = "tfex-security-workspace"
#   location = "westus"
# }

# resource "azurerm_log_analytics_workspace" "example" {
#   name                = "tfex-security-workspace"
#   location            = "${azurerm_resource_group.example.location}"
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   sku                 = "PerGB2018"
# }

# resource "azurerm_security_center_workspace" "example" {
#   scope        = "/subscriptions/00000000-0000-0000-0000-000000000000"
#   workspace_id = "${azurerm_log_analytics_workspace.example.id}"
# }
