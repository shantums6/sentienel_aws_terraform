pipeline {
    agent {
        docker { 
            image 'hashicorp/terraform:latest' 
            // We added --network host to bypass the Docker bridge entirely
            args '-u root:root --network host'
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