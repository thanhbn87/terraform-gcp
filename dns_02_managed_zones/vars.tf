variable "project_name" { default = "Example" }
variable "project_env" { default = "Production" }

variable "dns_private" { default = true }
variable "dns_public" { default = true }
variable "domain_public" { default = "example.com" }
variable "domain_private" { default = "example.internal" }
variable "network_self_link" {}
