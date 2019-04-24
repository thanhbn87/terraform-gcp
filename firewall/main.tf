resource "google_compute_firewall" "this" {
  name     = "${var.name}"
  network  = "${var.network_name}"
  priority = "${var.priority}"

  allow {
    protocol = "${var.protocol}"
    ports    = ["${var.ports}"]
  }

  source_ranges = ["${var.source_ranges}"]
  source_tags   = ["${var.source_tags}"]
  target_tags   = ["${var.target_tags}"]
}
