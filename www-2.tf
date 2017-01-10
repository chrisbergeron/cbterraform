resource "digitalocean_droplet" "www-2" {
    image = "centos-7-2-x64"
    name = "www-2"
    region = "nyc1"
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
      "sudo yum -y update",
      "sudo yum -y install epel-release",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
      "sudo wget https://github.com/digitalocean/doctl/releases/download/v1.5.0/doctl-1.5.0-linux-amd64.tar.gz",
      "sudo tar xvfz doctl-1.5.0-linux-amd64.tar.gz",
      "sudo mv doctl /usr/local/bin"
    ]
  }
}
