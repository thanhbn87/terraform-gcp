variable "project_id" {}
variable "region" { default = "us-west1" }
variable "num_of_zones" { default = "2" }

variable "name" { default = "gcp-instance" }
variable "instance_count" { default = "1" }
variable "static_external_ip" { default = false }
variable "subnetwork" { default = "" }
variable "instance_type" { default = "f1-micro" }
variable "tags" { default = [] }
variable "image" { default = "" }
variable "image_family" { default = "centos-7" }
variable "image_project" { default = "centos-cloud" }
variable "disk_size" { default = "10" }
variable "ssh_pub_file" { default = "../sshkeys/id_rsa.pub" }
variable "ssh_user" { default = "centos" }
variable "startup_script" { default = "startup.sh" }

/// DNS private:
variable "dns_private" {default = true}
variable "dns_ttl" {default = "300"}
variable "domain_private" {default = "example.internal"}
variable "dns_private_name" {default = "dns-internal"}
