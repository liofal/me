# Lionel Falise - Personal Resume Website

This repository contains the source code and infrastructure configuration for Lionel Falise's personal resume website.

**Live URL:** [https://me.liofal.net](https://me.liofal.net)

## Technology Stack

*   **Frontend:** Static HTML & CSS (`/src/me.html`)
*   **Hosting:** DigitalOcean App Platform
*   **Infrastructure as Code:** Terraform (`/iac` directory)
*   **Source Control:** GitHub

## Deployment

*   The infrastructure (DigitalOcean Project, App Platform App, DNS Zone) is managed by Terraform configuration located in the `/iac` directory.
*   Deployment requires a DigitalOcean API token. Prefer a custom-scoped token limited to projects, domains and apps (read-only is enough for `terraform plan`), with an expiry. Store it in `iac/.env`, which is git-ignored:
    ```bash
    # iac/.env
    export DIGITALOCEAN_TOKEN="YOUR_DIGITALOCEAN_API_TOKEN_HERE"
    ```
*   Load the token and run Terraform from the `iac` directory (Terraform `~> 1.11`):
    ```bash
    cd iac
    source .env
    terraform init # If first time or providers changed
    terraform plan
    terraform apply
    ```
*   Terraform state is local (`iac/terraform.tfstate`) and git-ignored. It can contain secrets and must never be committed; keep a backup, since it is the only copy.
*   The project and DNS zone are marked `prevent_destroy`; removing them requires deleting that guard first.
*   The website is configured to automatically redeploy the latest content from the `main` branch upon every push to the `liofal/me` GitHub repository.
*   DNS for the `me.liofal.net` subdomain is delegated to DigitalOcean and the necessary records are managed automatically by the App Platform service based on the Terraform configuration.

## Content

The resume content is located in `/src/me.html`.
