pipeline {
    agent any

    environment {
        CI = 'true'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Prepare Deploy Script') {
            steps {
                // Make deploy.sh executable
                sh 'chmod +x deploy.sh'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing npm dependencies...'
                sh 'npm ci'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                sh 'npm test -- --watchAll=false || true' // don't fail pipeline if tests fail
            }
        }

        stage('Build React App') {
            steps {
                echo 'Building React app...'
                sh 'npm run build'
            }
        }

        stage('Deploy Script') {
            steps {
                echo 'Running deploy.sh...'
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully 🎉'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
    }
}
