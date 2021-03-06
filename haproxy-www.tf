resource "digitalocean_droplet" "haproxy-www" {
    image = "ubuntu-14-04-x64"
    name = "haproxy-www"
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
      # install haproxy 1.5
      "sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
      "sudo apt-get -y update",
      "sudo apt-get -y install haproxy",

      # download haproxy conf
      "sudo wget https://gist.githubusercontent.com/thisismitch/91815a582c27bd8aa44d/raw/8fc59b7cb88a2be9b802cd76288ca1c2ea957dd9/haproxy.cfg -O /etc/haproxy/haproxy.cfg",

      # replace ip address variables in haproxy conf to use droplet ip addresses
      "sudo sed -i 's/HAPROXY_PUBLIC_IP/${digitalocean_droplet.haproxy-www.ipv4_address}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/WWW_1_PRIVATE_IP/${digitalocean_droplet.www-1.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/WWW_2_PRIVATE_IP/${digitalocean_droplet.www-2.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",

      # get doctl for Ubuntu
      "sudo wget https://github.com/digitalocean/doctl/releases/download/v1.5.0/doctl-1.5.0-linux-amd64.tar.gz",
      "sudo tar xvfz doctl-1.5.0-linux-amd64.tar.gz",
      "sudo mv doctl /usr/local/bin",

      # restart haproxy to load changes
      "sudo service haproxy restart"
    ]
  }
}
