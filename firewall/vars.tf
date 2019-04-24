variable "name" { default = "firewall" }
variable "network_name" { default = "default" }
variable "priority" { default = "1000" }
variable "protocol" { default = "tcp" }
variable "ports" { default = ["22","80","443"] }
variable "source_tags" { default = [] }
variable "source_ranges" { default = [] }
variable "target_tags" { default = [] }
