#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    options {
        timestamps()
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    ansiColor('xterm') {
                        echo "Initializing Terraform..."
                        dir('terraform-eks-deployment') {
                            try {
                                sh "terraform init"
                                echo "Validating Terraform configuration..."
                                sh "terraform validate"
                                echo "Planning Terraform deployment..."
                                sh "terraform plan"
                                echo "Applying Terraform configuration..."
                                sh "terraform apply -auto-approve"
                            } catch (Exception e) {
                                echo "Error: Terraform execution failed. Please check the logs for details."
                                error "Stopping pipeline due to Terraform error."
                            }
                        }
                    }
                }
            }
        }
    post {
        always {
            script {
                echo "Cleaning up workspace..."
                cleanWs()
            }
        }
    }
}