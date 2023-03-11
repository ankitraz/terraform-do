# DigitalOcean Droplet Deployment with Terraform
This repository contains a Terraform script that deploys a DigitalOcean droplet, sets up an SSH key, and configures a firewall to allow incoming traffic on ports 22 and 80.

## Prerequisites
Before running the Terraform script, make sure you have the following:

1. A DigitalOcean account
2. An API token for your DigitalOcean account
3. Terraform installed on your local machine
4. An `SSH` keypair generated on your local machine, or the public key of an existing keypair
## Usage
1. Clone this repository to your local machine.
2. Edit the variables.tf file to set your DigitalOcean API token and the path to your SSH public key file (if you're not using an existing keypair).
3. In your terminal, navigate to the root directory of the cloned repository.
4. Run terraform init to initialize the Terraform configuration.
5. Run terraform apply to apply the configuration and create the DigitalOcean droplet.
6. Wait for the Terraform script to finish executing. This will take a few minutes.
7. Once the script has finished executing, you should see the public IP address of your new droplet in the terminal output.
8. You can now SSH into your droplet using the IP address and your private SSH key.

## Jenkins Integration
### To integrate this Terraform script with a Jenkins pipeline, you can use the  Jenkinsfile provided in this repo:


* This Jenkinsfile assumes that you have a Jenkins credential named digitalocean-token that contains your DigitalOcean API token. You can modify the ssh_key variable to point to the path of your SSH public key file.

## License
This code is licensed under the MIT License.
