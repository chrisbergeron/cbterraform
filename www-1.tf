resource "digitalocean_droplet" "www-1" {
    image = "centos-7-2-x64"
    name = "www-1"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
connection {
      user = "root"
      type = "ssh"
      key_file = "${var.pvt_key}"
      timeout = "2m"
}
provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo yum -y update",
      "sudo yum -y install nginx"
      "sudo systemctl start nginx"
    ]
  }
}
