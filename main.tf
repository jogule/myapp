terraform {
  required_version = "~>1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.7"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg" {
  name     = "myapp-rg"
  location = "eastus"
}

resource "azurerm_service_plan" "plan" {
  name                = "myapp-linux-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P0v3"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "myapp-jonguz-xyz-webapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
  }
}

data "azurerm_dns_zone" "zone" {
  name                = "jonguz.xyz"
  resource_group_name = "platform-connectivity-rg-eastus"
}

resource "azurerm_dns_cname_record" "cname-record" {
  name                = "myapp"
  zone_name           = data.azurerm_dns_zone.zone.name
  resource_group_name = data.azurerm_dns_zone.zone.resource_group_name
  ttl                 = 3600
  record              = azurerm_linux_web_app.webapp.default_hostname
}

resource "azurerm_dns_txt_record" "txt-record" {
  name                = "asuid.${azurerm_dns_cname_record.cname-record.name}"
  zone_name           = data.azurerm_dns_zone.zone.name
  resource_group_name = data.azurerm_dns_zone.zone.resource_group_name
  ttl                 = 3600
  record {
    value = azurerm_linux_web_app.webapp.custom_domain_verification_id
  }
}

resource "azurerm_app_service_custom_hostname_binding" "domain" {
  hostname            = trim(azurerm_dns_cname_record.cname-record.fqdn, ".")
  app_service_name    = azurerm_linux_web_app.webapp.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_dns_txt_record.txt-record]

  # Ignore ssl_state and thumbprint as they are managed using
  # azurerm_app_service_certificate_binding.example
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

resource "azurerm_app_service_managed_certificate" "cert" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.domain.id
}

resource "azurerm_app_service_certificate_binding" "cert-binding" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.domain.id
  certificate_id      = azurerm_app_service_managed_certificate.cert.id
  ssl_state           = "SniEnabled"
}

resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_linux_web_app.webapp.id
  repo_url = "https://github.com/jogule/myapp"
  branch   = "main"

  github_action_configuration {
    code_configuration {
      runtime_stack   = "dotnetcore"
      runtime_version = "6.0"
    }
  }
}