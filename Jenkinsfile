pipeline {
    // 1. The Magic Agent: Spin up a fresh Terraform container for this job
    agent {
        docker { 
            image 'hashicorp/terraform:latest' 
            // We tell Docker to keep the container alive while Jenkins runs the shell commands
            args '-u root:root'
        }
    }

    // 2. The Workspace
    environment {
        // We will configure these credentials in the Jenkins UI in our next step!
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    // 3. The Automation Steps
    stages {
        stage('Code Checkout') {
            steps {
                // Pulls the latest code from GitHub
                checkout scm 
            }
        }

        stage('Terraform Init') {
            steps {
                // Navigate to your specific folder before running terraform
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
    }
}