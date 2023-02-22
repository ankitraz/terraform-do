terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "web" {
  name     = "my-droplet"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "BLR1"
  ssh_keys = [digitalocean_ssh_key.droplet-ssh-key.fingerprint]
}


# Create a new SSH key
resource "digitalocean_ssh_key" "droplet-ssh-key" {
  name       = "Terraform Example"
  public_key = file(var.ssh_key)
}

//this will give ipv4 address of our newly created droplet
output "droplet_ip" {
  value = digitalocean_droplet.web.ipv4_address
}

resource "digitalocean_firewall" "web" {
  name        = "only-22-80-firewall"
  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }


  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
