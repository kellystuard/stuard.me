variable "azure_location" {
  type        = string
  description = "The default location for Azure resources."
}

variable "forwarding_email_address" {
  type        = string
  description = "The address to forward standard email aliases to."
}

// Provider variables

variable "azure_client_id" {
  type        = string
  description = "The Azure client id for operations."
}

variable "azure_client_secret" {
  type        = string
  description = "The Azure client secret for operations."
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant id for operations."
}

variable "azure_subscription_id" {
  type        = string
  description = "The Azure subscription id for operations."
}

variable "cloudflare_api_key" {
  type        = string
  description = "The Cloudflare API Key for operations."
}

variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID to use."
}

