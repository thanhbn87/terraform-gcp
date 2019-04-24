output "dns_private_name" {
  value       = "${element(google_dns_managed_zone.private.*.name,0)}"
  description = "The name of private dns zone"
}

output "dns_public_name" {
  value       = "${element(google_dns_managed_zone.public.*.name,0)}"
  description = "The name of public dns zone"
}

output "domain_private" {
  value       = "${var.domain_private}."
  description = "The private domain name"
}

output "domain_public" {
  value       = "${var.domain_public}."
  description = "The public domain name"
}
