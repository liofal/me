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
*   Deployment requires a DigitalOcean API token with read/write permissions. Store this token in a `.env` file at the project root:
    ```bash
    # /workspaces/me/.env
    DIGITALOCEAN_TOKEN="YOUR_DIGITALOCEAN_API_TOKEN_HERE"
    ```
    *(Ensure `.env` is listed in your root `.gitignore` file).*
*   Before running Terraform commands, load the environment variable:
    ```bash
    source .env
    ```
*   Navigate to the infrastructure directory and apply changes:
    ```bash
    cd iac
    terraform init # If first time or providers changed
    terraform plan
    terraform apply
    ```
*   The website is configured to automatically redeploy the latest content from the `main` branch upon every push to the `liofal/me` GitHub repository.
*   DNS for the `me.liofal.net` subdomain is delegated to DigitalOcean and the necessary records are managed automatically by the App Platform service based on the Terraform configuration.

## Content

The resume content is located in `/src/me.html`.
