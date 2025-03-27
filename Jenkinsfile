pipeline {
    agent any

    stages {
        stage('Checkout Git') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-few',
                    url: 'https://github.com/oattoman7522/devops-assignment.git'
            }
        }

        stage('List Files') {
            steps {
                dir('./devops-assignment') {
                    sh "ls -al"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}