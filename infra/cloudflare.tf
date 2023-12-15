resource "cloudflare_zone" "stuard_me" {
  account_id = var.cloudflare_account_id
  zone       = "stuard.me"

  jump_start = false
  plan       = "free"
}

// Fighting Bots

resource "cloudflare_bot_management" "example" {
  zone_id = cloudflare_zone.stuard_me.id

  auto_update_model               = true
  enable_js                       = true
  sbfm_definitely_automated       = "block"
  sbfm_likely_automated           = "managed_challenge"
  sbfm_verified_bots              = "allow"
  sbfm_static_resource_protection = false
  optimize_wordpress              = false
}

// Email Setup

resource "cloudflare_email_routing_settings" "stuard_me" {
  zone_id = cloudflare_zone.stuard_me.id
  enabled = true

  skip_wizard = true
}

resource "cloudflare_email_routing_rule" "stuard_me" {
  for_each = toset([
    "webmaster", "abuse", "postmaster", "hostmaster"
  ])

  zone_id = cloudflare_zone.stuard_me.id
  name    = "${each.key} routing rule"
  enabled = true

  matcher {
    type  = "literal"
    field = "to"
    value = "${each.key}@${cloudflare_zone.stuard_me.zone}"
  }

  action {
    type  = "forward"
    value = [var.forwarding_email_address]
  }
}
