pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Hello from Jenkins — your CI/CD is working!'
            }
        }

        stage('Terraform Init & Apply') {
            environment {
                AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
                AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
                AWS_DEFAULT_REGION     = 'us-east-1'
            }
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
