data "google_compute_zones" "available" {}

data "google_compute_image" "this" {
  family  = "${var.image_family}"
  project = "${var.image_project}"
}

resource "google_compute_address" "this" {
  count  = "${var.static_external_ip ? "${var.instance_count}" : 0 }"
  name   = "${var.name}-${format("%02d", count.index + 1)}"
}

resource "google_compute_instance" "this" {
  count        = "${var.instance_count}"
  name         = "${var.name}-${format("%02d", count.index + 1)}"
  machine_type = "${var.instance_type}"
  zone         = "${data.google_compute_zones.available.names[count.index % "${var.num_of_zones}"]}"

  tags = ["${var.tags}"]

  boot_disk {
    initialize_params {
      image = "${var.image == "" ? "${data.google_compute_image.this.self_link}" : "${var.image}" }"
      size  = "${var.disk_size}"
    }
  }

  network_interface {
    subnetwork = "${var.subnetwork}"

    access_config {
      // External IP
      nat_ip = "${var.static_external_ip ? "${element(concat(google_compute_address.this.*.address, list("")),count.index)}" : "" }"
    }
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file("${var.ssh_pub_file}")}"
  }

}
