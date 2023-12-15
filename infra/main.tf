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
  api_token = var.cloudflare_api_token
}
