pipeline {
    agent {
        docker { 
            image 'hashicorp/terraform:latest' 
            args '-u root:root'
        }
    }

    // Notice the environment block with hardcoded credentials is completely GONE!

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