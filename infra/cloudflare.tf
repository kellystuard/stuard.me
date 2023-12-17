resource "cloudflare_zone" "stuard_me" {
  account_id = var.cloudflare_account_id
  zone       = "stuard.me"

  jump_start = false
  plan       = "free"
}



// DNS / Records

resource "cloudflare_record" "cname_root" {
  zone_id = cloudflare_zone.stuard_me.id
  name    = "@"
  value   = azurerm_static_site.root.default_host_name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "txt_azure" {
  zone_id = cloudflare_zone.stuard_me.id
  name    = "@"
  value   = azurerm_static_site_custom_domain.root.validation_token
  type    = "TXT"
}

resource "cloudflare_record" "cname_www" {
  zone_id = cloudflare_zone.stuard_me.id
  name    = "www"
  value   = azurerm_static_site.root.default_host_name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_home" {
  zone_id = cloudflare_zone.stuard_me.id
  name    = "home"
  value   = "z1755512.eero.online"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_minecraft" {
  zone_id = cloudflare_zone.stuard_me.id
  name    = "minecraft"
  value   = "z1755512.eero.online"
  type    = "CNAME"
  proxied = false
}

// Rules / Settings

resource "cloudflare_url_normalization_settings" "stuard_me" {
  zone_id = cloudflare_zone.stuard_me.id
  type    = "cloudflare"
  scope   = "incoming"
}

// Security / Bots

resource "cloudflare_bot_management" "stuard_me" {
  zone_id = cloudflare_zone.stuard_me.id

  auto_update_model  = true
  enable_js          = true
  fight_mode         = true
  optimize_wordpress = false
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

