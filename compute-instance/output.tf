output "ids" {
  value       = "${google_compute_instance.this.*.instance_id}" 
  description = "The IDs of the instance"
}

output "self_links" {
  value       = "${google_compute_instance.this.*.self_link}" 
  description = "The URIs of the instance"
}

output "private_ips" {
  value       = "${google_compute_instance.this.*.network_interface.0.network_ip }" 
  description = "The internal IPs of the instance"
}

output "public_ips" {
  value       = "${google_compute_instance.this.*.network_interface.0.access_config.0.nat_ip }" 
  description = "The given external IPs or the ephemeral IPs"
}
