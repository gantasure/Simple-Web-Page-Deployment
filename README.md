##Project Name: "Simple Web Page Deployment"

This project deploys a static HTML web page. It's simpler than a full application, allowing us to focus on the core DevOps principles.


################################



Project Structure:


simple-web-page-deployment/
├── index.html
├── Dockerfile
├── .dockerignore
├── Jenkinsfile
├── terraform/
│   └── main.tf
└── README.md

## Technologies Used

*   HTML
*   Nginx (as web server in Docker)
*   Docker
*   Jenkins
*   AWS EC2
*   Terraform
*   Git/GitHub

## Setup

1.  **AWS Setup:**
    *   Create an AWS account.
    *   Create an EC2 key pair.
    *   Configure your AWS credentials.
    *   Get your default VPC ID.

2.  **Terraform:**
    *   Install Terraform.
    *   Navigate to the `terraform/` directory.
    *   Replace `"your_aws_region"`, `"your_ec2_key_pair"`, and `"your_vpc_id"` in `main.tf` with your values.
    *   Run `terraform init` and `terraform apply`.

3.  **Jenkins:**
    *   Install Jenkins.
    *   Install the necessary plugins (Git, Docker Pipeline, Publish Over SSH).
    *   Configure your AWS credentials and EC2 SSH key in Jenkins. Create a credential for Docker Hub if you plan to use it.
    *   Configure the EC2 SSH server in Jenkins settings.
    *   Create a new Jenkins pipeline job and point it to your GitHub repository.

4.  **GitHub Webhook:**
    *   Configure a GitHub webhook to trigger the Jenkins pipeline on push events.

## Usage

1.  Make changes to the `index.html` file.
2.  Commit and push your changes to your GitHub repository.
3.  The Jenkins pipeline will automatically build, push (optionally), and deploy your web page to the EC2 instance.

## Accessing the Web Page

Once the pipeline completes, you can access the web page by navigating to the public IP address of your EC2 instance in a web browser. You can get the public IP from the Terraform output or the AWS EC2 console.

## Project Name Ideas

*   Simple Web Page Deployment Automation
*   Automated Static Website Deployment
*
