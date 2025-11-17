pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub-creds')
        IMAGE = "hareesh88666/maven-web-application"
    }

    stages {
        
        stage('Clone Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/hareesh88666/maven-web-application.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                docker build -t ${IMAGE}:${BUILD_NUMBER} .
                """
            }
        }

        stage('Docker Login') {
            steps {
                sh """
                echo "${DOCKERHUB_PSW}" | docker login -u "${DOCKERHUB_USR}" --password-stdin
                """
            }
        }

        stage('Docker Push') {
            steps {
                sh """
                docker push ${IMAGE}:${BUILD_NUMBER}
                """
            }
        }

        stage('Cleanup Local Images') {
            steps {
                sh """
                docker rmi ${IMAGE}:${BUILD_NUMBER} || true
                """
            }
        }
    }
}
