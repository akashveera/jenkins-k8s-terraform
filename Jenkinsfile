#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-southeast-2"
    }
    options {
        timestamps()
    }
    stages {
        stage('Destroy') {
            steps {
                script {
                    ansiColor('xterm') {
                        echo "Initializing Terraform..."
                        dir('terraform-eks-deployment') {
                            try {
                                sh "terraform init"
                                echo "Validating Terraform configuration..."
                                sh "terraform destroy -auto-approve"
                                echo "Destroy Terraform deployment..."
                            } catch (Exception e) {
                                echo "Error: Terraform execution failed. Please check the logs for details."
                                error "Stopping pipeline due to Terraform error."
                            }
                        }
                    }
                }
        }
    }
}
