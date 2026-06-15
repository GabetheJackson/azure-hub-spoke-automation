# azure-hub-spoke-automation

This project demonstrates an enterprise-grade cloud network architecture deployed using Infrastructure as Code (Terraform).

## Architecture
- **Hub-and-Spoke Topology:** Centralized hub for shared services, isolated spoke networks for production/dev environments.
- **Security:** Implemented Network Security Groups (NSGs) to enforce zero-trust access.
- **Automation:** Fully automated deployment using Terraform azurerm provider.

## How to Deploy,
- Ensure Azure CLI is authenticated.
- Initialize: terraform init
- Plan: terraform plan
- Apply: terraform apply

Topology,
<img width="641" height="577" alt="image" src="https://github.com/user-attachments/assets/380c1fb3-e99c-41fe-a054-b9babeffc3f9" />
