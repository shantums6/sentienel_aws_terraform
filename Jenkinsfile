pipeline {
    agent {
        docker { 
            image 'hashicorp/terraform:latest' 
            // Added --entrypoint='' to force Jenkins to take control
            args '-u root:root --entrypoint='
        }
    }

    environment {
        // Terraform still needs to know which datacenter to talk to
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
    }
}