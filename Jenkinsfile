pipeline {
    agent {
        docker { 
            image 'hashicorp/terraform:latest' 
            args '-u root:root --entrypoint='
        }
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Code Checkout') {
            steps {
                checkout scm 
            }
        }

        stage('Terraform Init') {
            steps {
                dir('shared_services') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('shared_services') {
                    sh 'terraform plan'
                }
            }
        }
        
        // 🚀 THE NEW STAGE: Build the infrastructure!
        stage('Terraform Apply') {
            steps {
                dir('shared_services') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}