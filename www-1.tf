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
      "sudo yum -y update",
      "sudo yum -y install epel-release",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
      "sudo wget https://github.com/digitalocean/doctl/releases/download/v1.5.0/doctl-1.5.0-linux-amd64.tar.gz",
      "sudo tar xvfz doctl-1.5.0-linux-amd64.tar.gz",
      "sudo mv doctl /usr/local/bin",
      "sudo rm -f doctl-1.5.0-linux-amd64.tar.gz",
      "sudo yum -y install mariadb-server mariadb",
      "sudo systemctl start mariadb",
      "sudo mysql -e \"UPDATE mysql.user SET Password=PASSWORD('test') WHERE User='root';\"",
      "sudo mysql -e \"DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');\"",
      "sudo mysql -e \"DELETE FROM mysql.user WHERE User='';\"",
      "sudo mysql -e \"DROP DATABASE test;\"",
      "sudo mysql -e \"FLUSH PRIVILEGES;\"",
      "sudo systemctl enable mariadb"
    ]
  }
}