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

        stage('Update GitOps Repo') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds',
                usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {

                    sh """
                        # Install yq if not present
                        if ! command -v yq &> /dev/null; then
                            echo "Installing yq..."
                            sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
                            sudo chmod +x /usr/bin/yq
                        fi

                        # Clone GitOps repo
                        rm -rf maven-webapp-gitops
                        git clone https://${GIT_USER}:${GIT_PASS}@github.com/hareesh88666/maven-webapp-gitops.git

                        cd maven-webapp-gitops/maven-webapp

                        echo "Detecting active version..."

                        ACTIVE=\$(yq eval '.activeVersion' values-blue.yaml 2>/dev/null || echo "")

                        if [ "\$ACTIVE" = "blue" ]; then
                            echo "BLUE is active → updating values-blue.yaml"
                            yq eval ".image.tag = \\"${BUILD_NUMBER}\\"" -i values-blue.yaml
                        else
                            echo "GREEN is active → updating values-green.yaml"
                            yq eval ".image.tag = \\"${BUILD_NUMBER}\\"" -i values-green.yaml
                        fi

                        cd ..

                        # Commit changes
                        git config --global user.email "jenkins@ci.com"
                        git config --global user.name "Jenkins"

                        git add .
                        git commit -m "Auto update image tag to ${BUILD_NUMBER}" || echo "No changes to commit"
                        git push https://${GIT_USER}:${GIT_PASS}@github.com/hareesh88666/maven-webapp-gitops.git
                    """
                }
            }
        }
    }
}
