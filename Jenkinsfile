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
        stage("Wait for EKS Cluster") {
            steps {
                script {
                    ansiColor('xterm') {
                        echo "Waiting for EKS cluster to be ready..."
                        retry(10) {
                            sleep(time: 60, unit: 'SECONDS')
                            def clusterStatus = sh(
                                script: "aws eks describe-cluster --name my-eks-cluster --region ${AWS_DEFAULT_REGION} --query 'cluster.status' --output text",
                                returnStdout: true
                            ).trim()
                            if (clusterStatus != 'ACTIVE') {
                                error "EKS cluster is not ready yet. Status: ${clusterStatus}. Retrying..."
                            }
                            echo "EKS cluster is ready. Status: ${clusterStatus}"
                        }
                    }
                }
            }
        }
        stage('Checkout') {
            steps {
                script {
                    echo "Checking out the code from SCM..."
                    checkout scm
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        echo "Building Docker image for Nginx web server..."
                        docker.build("${IMAGE_NAME}", "./kubernetes/")
                    } catch (Exception e) {
                        echo "Error during Docker build process:"
                        throw e
                    }
                }
            }
        }
        stage('Login to AWS ECR') {
            steps {
                script {
                    echo "Logging in to AWS ECR..."
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                script {
                    def ecrRepo = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_NAME}"
                    def latestTag = "${ecrRepo}:latest"

                    echo "Tagging and pushing Docker image to ECR..."
                    sh """
                        docker tag ${IMAGE_NAME} ${latestTag}
                        docker push ${latestTag}
                    """
                }
            }
        }
        stage('Update Deployment File') {
            steps {
                script {
                    echo "Updating Kubernetes deployment file with new image tag..."
                    sh """
                        sed -i -e 's|AWS_ACCOUNT_ID_PLACEHOLDER|${AWS_ACCOUNT_ID}|' \\
                            -e 's|AWS_REGION_PLACEHOLDER|${AWS_DEFAULT_REGION}|' \\
                            -e 's|IMAGE_NAME_PLACEHOLDER|${IMAGE_NAME}|' \\
                            -e 's|IMAGE_TAG_PLACEHOLDER|${env.BUILD_NUMBER}|' \\
                            kubernetes/nginx-deployment.yaml
                    """
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    ansiColor('xterm') {
                        dir('kubernetes') {
                            try {
                                echo "Applying Kubernetes deployment for Nginx..."
                                sh "kubectl apply -f nginx-deployment.yaml"
                                echo "Applying Kubernetes service for Nginx..."
                                sh "kubectl apply -f nginx-service.yaml"
                            } catch (Exception e) {
                                echo "Error: Kubernetes deployment failed. Please check the logs for details."
                                error "Stopping pipeline due to Kubernetes error."
                            }
                        }
                    }
                }
            }
        }
        stage('Wait for Load Balancer') {
            steps {
                script {
                    ansiColor('xterm') {
                        echo "Waiting for Load Balancer to be created..."
                        retry(20) {
                            sleep(time: 30, unit: 'SECONDS')
                            def loadBalancerIP = sh(
                                script: "kubectl get svc nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'",
                                returnStdout: true
                            ).trim()
                            if (!loadBalancerIP) {
                                error "Load Balancer is not ready yet. Retrying..."
                            }
                            echo "Load Balancer is ready. IP/Hostname: ${loadBalancerIP}"
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
