variable "cloudflare_api_token" {
  type        = string
  description = "The Cloudflare API Token for operations."
}

variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID to use."
}

variable "forwarding_email_address" {
  type        = string
  description = "The address to forward standard email aliases to."
}