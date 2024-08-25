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
        stage("Delete Kubernetes Deployment and Service") {
            steps {
                script {
                    ansiColor('xterm') {
                        dir('kubernetes') {
                            try {
                                echo "Deleting Kubernetes Nginx deployment..."
                                sh "kubectl delete -f nginx-deployment.yaml || true"
                                echo "Deleting Kubernetes Nginx service..."
                                sh "kubectl delete -f nginx-service.yaml || true"
                            } catch (Exception e) {
                                echo "Error: Kubernetes resource deletion failed. Please check the logs for details."
                                error "Stopping pipeline due to Kubernetes error."
                            }
                        }
                    }
                }
            }
        }

        stage("Wait Before Destroying Kubernetes Resources, specifically load Balancer") {
            steps {
                script {
                    echo "Waiting for resources to be deleted..."
                    sleep(time: 60, unit: 'SECONDS') // Wait for 60 seconds before moving to the next stage
                }
            }
        }
        
        stage("Destroy Terraform Resources") {
            steps {
                script {
                    ansiColor('xterm') {
                        echo "Initializing Terraform..."
                        dir('terraform-eks-deployment') {
                            try {
                                sh "terraform init"
                                echo "Destroying Terraform configuration..."
                                sh "terraform destroy -auto-approve"
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
}
