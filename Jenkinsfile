pipeline {
    agent any 

    environment {
        NAME = 'Jenkins'
        TOOL = 'CI/CD'
        APP_VERSION = '1.0'
        ENVIRONMENT = 'staging'
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
            // environment {
            //     ENVIRONMENT = "staging"
            // }

            when {
                // expression {
                //     env.ENVIRONMENT == "staging"
                // }
                environment(name: 'ENVIRONMENT', value: 'staging')
            }
            steps {
                echo "Deploying the application in ${ENVIRONMENT} environment"
            }
        }
    }

    post {
        always {
            echo "Pipeline completed"
        }

        failure {
            echo "Pipeline failed"
        }

        success {
            echo "Pipeline succeeded"
        }
    }
}