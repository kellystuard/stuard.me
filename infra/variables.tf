variable "cloudflare_api_key" {
  type        = string
  description = "The Cloudflare API Key for operations."
}

variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID to use."
}

variable "forwarding_email_address" {
  type        = string
  description = "The address to forward standard email aliases to."
}