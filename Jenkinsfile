pipeline {
  agent any

  stages {
    stage('Test') {
      steps {
        echo 'Hello from Jenkins — your CI/CD is working!'
      }
    }
    stage('Terraform Init & Apply') {
      steps {
        sh '''
          cd terraform
          terraform init
          terraform apply -auto-approve
        '''
      }
    }

  }
}
