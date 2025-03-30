pipeline {
    agent any

    parameters {
        choice(name: 'Environment', choices: ['DEV', 'STA', 'PROD'], description: 'Select Environment to deploy application')
    }

    environment {
        DOCKER_IMAGE = "go"
        DOCKER_TAG = "${BUILD_NUMBER}"
        IMAGE_REGISTY_URL = "ghcr.io"
        KUBECONFIG = credentials('kubeconfig')
        ENV = "${params.Environment}"
        
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
                echo "${ENV}"
            }
        }

        stage('Build Application') {
            steps {
                sh 'docker build -t $IMAGE_REGISTY_URL/oattoman7522/$DOCKER_IMAGE:$DOCKER_TAG . '
            }
        }

        stage('Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-few', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                            echo $PASSWORD | docker login $IMAGE_REGISTY_URL -u $USERNAME -p $PASSWORD
                            docker push $IMAGE_REGISTY_URL/oattoman7522/$DOCKER_IMAGE:$DOCKER_TAG
                            docker rmi $IMAGE_REGISTY_URL/oattoman7522/$DOCKER_IMAGE:$DOCKER_TAG
                        """
                    }
                }
            }
        }

         stage('Patch file kustomiza') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-few', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                            echo "Sed value TAG_NUMBER env. DEV"
                            sed -i 's/TAG_NUMBER/$DOCKER_TAG/g' Kustomize/overlay/dev/kustomization.yaml 
                            cat Kustomize/overlay/dev/kustomization.yaml
                            echo "Sed value TAG_NUMBER env. PROD"
                            sed -i 's/TAG_NUMBER/$DOCKER_TAG/g' Kustomize/overlay/prod/kustomization.yaml
                            cat Kustomize/overlay/prod/kustomization.yaml
                        """
                    }
                }
            }
        }

        stage('Deploy application with argoCD ') {
            steps {
                script {
                    if (env.ENV == 'DEV') {
                        sh """
                        mkdir -p .kube
                        echo "$KUBECONFIG" > .kube/kubeconfig
                        export KUBECONFIG=.kube/kubeconfig
                        kubectl create -f argocd/dev-argocd.yaml
                        """
                    } else if (env.ENV == 'PROD') {
                        input message: "Do you want to deploy application in ${env.ENV}?", ok: "Yes"
                        sh """
                        mkdir -p .kube
                        echo "$KUBECONFIG" > .kube/kubeconfig
                        export KUBECONFIG=.kube/kubeconfig
                        kubectl create -f argocd/prod-argocd.yaml
                        """
                    } else {
                        echo 'Deploy application failed.'
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