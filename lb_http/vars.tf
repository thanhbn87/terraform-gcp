variable "name" { default = "LB for Unmanaged instance group" }
variable "desc" { default = "Load Balancer for The group of unmanaged instances" }
variable "instance_count" { default = "0" }
variable "gce_self_links" { default = [] }
variable "http_port" { default = "80" }
variable "http_port_name" { default = "http" }
variable "http_check_path" { default = "/" }
variable "https_port" { default = "443" }
variable "https_port_name" { default = "https" }

variable "target_tags" { default = ["web"] }
variable "firewall_networks" { default = ["default"] }
