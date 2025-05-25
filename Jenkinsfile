pipeline {
    agent any

    environment {
        IMAGE_NAME = "docker-sample-app"
        AWS_REGION = "ca-central-1"
        ECR_REPO = "897722705551.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMAGE_NAME}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/snehabopche/docker-sample-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                script {
                    sh """
                    docker tag ${IMAGE_NAME}:latest ${ECR_REPO}:latest
                    docker push ${ECR_REPO}:latest
                    """
                }
            }
        }

        stage('Run Container Locally') {
            steps {
                sh 'docker run -d -p 80:80 ${IMAGE_NAME}'
            }
        }
    }
}

