pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-southeast-2"
    }

    options {
        timestamps() // Adds timestamps to log output
        ansiColor('xterm') // Colorize console output
        buildDiscarder(logRotator(numToKeepStr: '5')) // Keeps the last 5 builds
    }

    stages {
        stage("Initialize Terraform and Validate") {
            steps {
                script {
                    dir('terraform-eks-deployment') {
                        try {
                            echo "Initializing Terraform..."
                            sh "terraform init"

                            echo "Validating Terraform configuration..."
                            sh "terraform validate"
                        } catch (Exception e) {
                            echo "Error during Terraform initialization/validation: ${e.message}"
                            error "Pipeline stopped due to Terraform initialization/validation error."
                        }
                    }
                }
            }
        }

        stage("Plan Terraform Deployment") {
            steps {
                script {
                    dir('terraform-eks-deployment') {
                        try {
                            echo "Planning Terraform deployment..."
                            sh "terraform plan"

                            echo "Terraform plan created successfully."
                        } catch (Exception e) {
                            echo "Error during Terraform planning: ${e.message}"
                            error "Pipeline stopped due to Terraform planning error."
                        }
                    }
                }
            }
        }

        stage("Apply Terraform Configuration") {
            steps {
                script {
                    dir('terraform-eks-deployment') {
                        try {
                            echo "Applying Terraform configuration..."
                            sh "terraform apply -auto-approve"

                            echo "Terraform apply completed successfully."
                        } catch (Exception e) {
                            echo "Error during Terraform apply: ${e.message}"
                            error "Pipeline stopped due to Terraform apply error."
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs() // Clean up the workspace after every build
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the error logs for details.'
        }
    }
}
