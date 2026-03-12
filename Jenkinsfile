pipeline {
    agent any 

    environment {
        NAME = 'Jenkins'
        TOOL = 'CI/CD'
        APP_VERSION = '1.0'
    }

    stages {
        stage('Build') {
            steps {
                echo "Building the application with ${TOOL} ${NAME} with app version ${APP_VERSION}"
            }
        }
        stage('Test') {
            steps {
                echo "Testing the application version with ${APP_VERSION}"
            }
        }
        stage('Deploy') {
            environment {
                ENVIRONMENT = "staging"
            }

            when {
                branch 'main'
            }
            steps {
                echo "Deploying the application in ${ENVIRONMENT} environment"
            }
        }
    }
}