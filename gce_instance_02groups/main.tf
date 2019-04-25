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
  zone         = "${data.google_compute_zones.available.names[count.index % 2]}"

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

  metadata_startup_script = "${file("${var.startup_script}")}"
  metadata {
    sshKeys = "${var.ssh_user}:${file("${var.ssh_pub_file}")}"
  }

}

data "null_data_source" "instance_lists" {
  count  = "${length(var.instance_count)}"
  inputs = {
    self_links_01 = "${ "${floor(count.index % 2)}" == 0 ? "${element(google_compute_instance.this.*.self_link,count.index)}" : "" }"
    self_links_02 = "${ "${floor(count.index % 2)}" == 1 ? "${element(google_compute_instance.this.*.self_link,count.index)}" : "" }"
  }
}

resource "google_compute_instance_group" "group_01" {
  count       = "${var.instance_count > 0 ? 1 : 0}"
  name        = "${var.name}-01"
  description = "${var.desc} group 01"

  instances = ["${compact(data.null_data_source.instance_lists.*.inputs["self_links_01"])}"]

  named_port {
    name = "http"
    port = "${var.http_port}"
  }

  named_port {
    name = "https"
    port = "${var.https_port}"
  }

  zone = "${data.google_compute_zones.available.names[0]}"
}

resource "google_compute_instance_group" "group_02" {
  count       = "${var.instance_count > 1 ? 1 : 0}"
  name        = "${var.name}-02"
  description = "${var.desc} 02"

  instances = ["${compact(data.null_data_source.instance_lists.*.inputs["self_links_02"])}"]

  named_port {
    name = "http"
    port = "${var.http_port}"
  }

  named_port {
    name = "https"
    port = "${var.https_port}"
  }

  zone = "${data.google_compute_zones.available.names[1]}"
}

data "null_data_source" "backends" {
  count   = "2"
  inputs {
    group = "${element(
                 "${compact(concat(
                   google_compute_instance_group.group_01.*.self_link,
                   google_compute_instance_group.group_02.*.self_link,
                   list("")
                 ))}",
                 count.index
            )}"
  }
}

/// DNS private:
resource "google_dns_record_set" "private" {
  count        = "${var.dns_private ? "${var.instance_count}" : 0}"
  name         = "${var.name}-${format("%02d", count.index + 1)}.${var.domain_private}."
  type         = "A"
  ttl          = "${var.dns_ttl}"

  managed_zone = "${var.dns_private_name}"

  rrdatas = ["${element(google_compute_instance.this.*.network_interface.0.network_ip,count.index)}"]
}
