resource "cloudflare_zone" "stuard_me" {
  account_id = var.cloudflare_account_id
  zone       = "stuard.me"

  jump_start = false
  plan       = "free"
}

// Rules / Settings

resource "cloudflare_url_normalization_settings" "example" {
  zone_id = "0da42c8d2132a9ddaf714f9e7c920711"
  type    = "cloudflare"
  scope   = "incoming"
}

// Security / Bots

resource "cloudflare_bot_management" "example" {
  zone_id = cloudflare_zone.stuard_me.id

  auto_update_model               = true
  enable_js                       = true
  fight_mode                      = true
  optimize_wordpress              = false
}

// Email / Email Routing

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

