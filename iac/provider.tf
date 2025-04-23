terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
# Your DigitalOcean API token should be set via the DIGITALOCEAN_TOKEN environment variable.
# export DIGITALOCEAN_TOKEN="your_do_api_token_here"
provider "digitalocean" {
  # token = var.do_token # Alternatively, use input variables if preferred
}
