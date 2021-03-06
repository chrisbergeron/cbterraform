output "Loadbalancer Public IP" {
	value = "${digitalocean_droplet.haproxy-www.ipv4_address}"
}
output "Loadbalancer Public IP" {
	value = "${digitalocean_droplet.haproxy-www.ipv4_address_private}"
}

output "www-1 Public IP" {
	value = "${digitalocean_droplet.www-1.ipv4_address}"
}
output "www-2 Public IP" {
	value = "${digitalocean_droplet.www-2.ipv4_address}"
}

output "www-1 Private IP" {
	value = "${digitalocean_droplet.www-1.ipv4_address_private}"
}
output "www-2 Private IP" {
	value = "${digitalocean_droplet.www-2.ipv4_address_private}"
}
