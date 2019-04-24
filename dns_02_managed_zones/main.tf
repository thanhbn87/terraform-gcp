////// DNS Zones:
resource "google_dns_managed_zone" "private" {
  count       = "${var.dns_private ? 1 : 0}" 
  name        = "${lower(var.project_name)}-private"
  dns_name    = "${var.domain_private}."
  description = "${var.project_name} Private Zone"
  labels = {
    env  = "${lower(var.project_env)}"
  }

  visibility  = "private"

  private_visibility_config {
    networks {
      network_url =  "${var..network_self_link}"
    }
  }
}

resource "google_dns_managed_zone" "public" {
  count       = "${var.dns_public ? 1 : 0}" 
  name        = "${lower(var.project_name)}-public"
  dns_name    = "${var.domain_public}."
  description = "${var.project_name} Public Zone"
  labels = {
    env  = "${lower(var.project_env)}"
  }

  visibility  = "public"

}
