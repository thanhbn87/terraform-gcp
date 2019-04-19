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
