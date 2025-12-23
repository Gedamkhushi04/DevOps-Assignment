pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling code from Git...'
                checkout scm
            }
        }

        stage('Infrastructure Security Scan') {
            steps {
                echo 'Scanning Terraform files for vulnerabilities...'
                // This command runs Trivy and will show the results in your Jenkins console
                sh 'trivy config ./terraform'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t devops-assignment-app ./app'
            }
        }

        stage('Run Container') {
            steps {
                echo 'Cleaning up old containers and running new one...'
                // This script stops any old container on port 5000 to avoid the "port already allocated" error
                sh '''
                docker stop devops-app-container || true
                docker rm devops-app-container || true
                docker run -d -p 5000:5000 --name devops-app-container devops-assignment-app
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution finished.'
        }
    }
}
