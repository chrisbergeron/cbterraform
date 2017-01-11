resource "digitalocean_volume" "data0" {
  region      = "nyc1"
  name        = "test-volume-123"
  size        = 1
  description = "test volume 123"
}
