pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "go"
        DOCKER_TAG = "${BUILD_NUMBER}"
        IMAGE_REGISTY_URL = "ghcr.io"
    }

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
                sh 'ls -al'
            }
        }

        stage('Build Application') {
            steps {
                sh 'docker build -t $IMAGE_REGISTY_URL/devops-test/$DOCKER_IMAGE:DOCKER_TAG . '
            }
        }

        stage('Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-few', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                            echo $PASSWORD | docker login $IMAGE_REGISTY_URL -u $USERNAME --password-stdin
                            docker push $IMAGE_REGISTY_URL/devops-test/$DOCKER_IMAGE:DOCKER_TAG
                        """
                    }
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