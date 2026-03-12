pipeline {
    agent any

    environment {
        APP_NAME    = 'cicd-demo-app'
        IMAGE_TAG   = "${BUILD_NUMBER}"
    }

    stages {

        // ─────────────────────────────────────────
        // STAGE 1: Get the code from GitHub
        // ─────────────────────────────────────────
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                checkout scm
            }
        }

        // ─────────────────────────────────────────
        // STAGE 2: Install dependencies & run tests
        // ─────────────────────────────────────────
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r app/requirements.txt
                    cd app && pytest test_app.py -v
                '''
            }
            post {
                success {
                    echo '✅ All tests passed!'
                }
                failure {
                    echo '❌ Tests failed — stopping pipeline'
                }
            }
        }

        // ─────────────────────────────────────────
        // STAGE 3: Build Docker image
        // ─────────────────────────────────────────
        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh '''
                    docker build -t ${APP_NAME}:${IMAGE_TAG} .
                    docker tag ${APP_NAME}:${IMAGE_TAG} ${APP_NAME}:latest
                '''
            }
            post {
                success {
                    echo "✅ Docker image built: ${APP_NAME}:${IMAGE_TAG}"
                }
            }
        }

        // ─────────────────────────────────────────
        // STAGE 4: Deploy locally (run container)
        // ─────────────────────────────────────────
        stage('Deploy') {
            steps {
                echo '🚀 Deploying container...'
                sh '''
                    # Stop existing container if running
                    docker stop ${APP_NAME} || true
                    docker rm   ${APP_NAME} || true

                    # Run new container
                    docker run -d \
                        --name ${APP_NAME} \
                        --restart unless-stopped \
                        -p 5000:5000 \
                        -e APP_ENV=production \
                        -e APP_VERSION=${IMAGE_TAG} \
                        ${APP_NAME}:latest

                    # Wait for app to start
                    sleep 5

                    # Health check
                    curl -f http://localhost:5000/health || exit 1
                '''
            }
            post {
                success {
                    echo '✅ Deployment successful! App running at http://localhost:5000'
                }
                failure {
                    echo '❌ Deployment failed — rolling back'
                    sh 'docker stop ${APP_NAME} || true'
                }
            }
        }
    }

    // ─────────────────────────────────────────
    // AFTER PIPELINE: notify result
    // ─────────────────────────────────────────
    post {
        success {
            echo '''
            ✅ Pipeline completed successfully!
            App is live at http://localhost:5000
            '''
        }
        failure {
            echo '❌ Pipeline failed — check the logs above'
        }
        always {
            echo "Pipeline finished — Build #${BUILD_NUMBER}"
        }
    }
}