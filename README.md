# superloop-technical-assessment
This is an end-to-end project to deploy a Nginx web server through Jenkins and Kubernetes, using Terraform. What we will build will have this structure:
![alt text](image.png)

## Project Description
This repository contains the solution for the Superloop technical assessment. The project demonstrates the implementation of Nginx web server through Jenkins and Kubernetes, using Terraform.

To do this, we will follow several steps:

    Create a Jenkins server and install all the dependencies
    Access and setup the Jenkins server with Github and AWS credentials. 
    Create Jenkins pipeline and run the Jenkins pipeline to deploy EKS Cluster.
    Create another Jenkins pipeline to build and deploy Nginx Web Server to the EKS cluster using K8 deployment and service (loadbalancer) 
    Test the application to make sure it’s running
    Clean up and destroy all resources
This project is just one environment deployment, so we will have just a dev environment.

### Project Structure
1. terraform-jenkins-server -> Terraform code to create Jenkins server and install all dependencies using terraform locally.
2. terraform-eks-deployment -> Terraform code to create the EKS cluster and ECR using terraform via jenkins pipeline.
3. kubernetes               -> Contains Dockerfile to create Nginx web server with a custom index.html and yaml files to create deployment and services.
4. Jenkinsfile              -> Groovy script to create EKS cluster
5. Jenkinsfile-build-deploy-nginx -> Groovy script to build and deploy Nginx web server to EKS.
6. Jenkinsfile-destroy      -> Groovy script ti destroy aws terraform resources specifcally the EKS cluster.

## Prerequisites
- AWS Account
- Git installed in your local computer.
- Ec2 Key pair for your Jenkins server - use the same name in the key_name section of the jenkins server -> https://github.com/akashveera/superloop-technical-assessment/blob/master/terraform-jenkins-server/server.tf#L17
- Terraform installed on your local computer. https://k21academy.com/terraform-iac/terraform-installation-overview/
- IAM credentials with enough permissions to create resources in AWS and programmatic access keys.
- AWS credentials that are set up locally with aws configure.

## Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/superloop-technical-assessment.git
    ```
2. Navigate to the project directory:
    ```sh
    cd superloop-technical-assessment
    ```
3. Install dependencies:
    ```sh
    [Provide installation commands, e.g., terraform and AWS cli]
    ```

## Running the Project
1. Navigate to the jenkins project directory:
    ```sh
    cd superloop-technical-assessment/terraform-jenkins-server
    ```
2. Run Terraform commands to deploy the Jenkins server in AWS
    ```sh
    terraform init
    terraform validate
    terraform plan
    terraform apply -auto-approve
    ```
3. Access and setup the Jenkins server with Github and AWS credentials.

## Additional Information
- [Any additional notes or information about the project]

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.