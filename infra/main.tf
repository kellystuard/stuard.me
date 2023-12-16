terraform {
  required_version = ">= 1.6.5"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.20"
    }
  }
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email   = var.forwarding_email_address
}

