# Define the DigitalOcean Project
resource "digitalocean_project" "me_liofal_net" {
  name        = "me.liofal.net"
  description = "Project hosting my static resume website"
  purpose     = "Web Application"
  environment = "Production"
}

# Define the DigitalOcean Domain for the delegated subdomain
resource "digitalocean_domain" "me_liofal_net_zone" {
  name = "me.liofal.net"
}

# Define the DigitalOcean App
resource "digitalocean_app" "resume_app" {
  project_id = digitalocean_project.me_liofal_net.id

  spec {
    name   = "liofal-resume-app"
    region = "fra"

    # Keep the domain block so App Platform knows to expect traffic
    domain {
      name = "me.liofal.net"
      type = "PRIMARY"
      # Associate with the DO managed zone for the subdomain
      zone = digitalocean_domain.me_liofal_net_zone.name
    }

    static_site {
      name = "resume-site"
      github {
        repo           = "liofal/me"
        branch         = "main"
        deploy_on_push = true
      }
      source_dir     = "/src" # Assuming this is correct now
      index_document = "me.html"
    }
  }
}

# --- Outputs ---

# Output the app's default live URL (still useful for direct access)
output "app_url" {
  value = digitalocean_app.resume_app.live_url
}

# Output the custom domain URL
output "custom_domain_url" {
  value = "https://${digitalocean_app.resume_app.spec[0].domain[0].name}"
}

# Output the project ID
output "project_id" {
  value = digitalocean_project.me_liofal_net.id
}

# Output the default DO ingress URL (needed for CNAME value derivation)
output "default_ingress_url" {
  description = "The default URL assigned by DigitalOcean"
  value       = digitalocean_app.resume_app.default_ingress
}

# Assign resources to the project (for UI organization)
resource "digitalocean_project_resources" "me_liofal_net_assignments" {
  project = digitalocean_project.me_liofal_net.id
  # List of resource URNs to assign
  resources = [
    digitalocean_app.resume_app.urn,
    digitalocean_domain.me_liofal_net_zone.urn,
  ]
}
