resource "cloudflare_zone" "stuard_me" {
  account_id = var.cloudflare_account_id
  zone       = "stuard.me"

  jump_start = false
  plan       = "free"
}

// Email Setup

resource "cloudflare_email_routing_settings" "stuard_me" {
  zone_id = cloudflare_zone.stuard_me.id
  enabled = true
}

resource "cloudflare_email_routing_rule" "main" {
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

