pipeline {
    agent any 

    environment {
        BUILD_TOOL = 'CI/CD'
        APP_VERSION = '1.0'
        ENVIRONMENT = 'staging'
    }

    parameters {
        string(name: 'APP_VERSION', defaultValue: '1.0', description: 'Application version')
        choice(name: 'ENVRIONMENT', choices: ['dev', 'staging', 'prod'], description: 'Envrionment')
    }
    // triggers {
    //     cron('H/5 * * * *')
    //     pollSCM('H/5 * * * *')
    // }

    stages {
        stage('Build') {
            steps {
                echo "Building the application with ${BUILD_TOOL} ${APP_NAME} with app version ${APP_VERSION}"
            }
        }
        stage('Test') {
            failFast true
            parallel {
                stage('Unit Tests') {
                    steps {
                        echo "Running unit tests"
                        sleep 2
                        echo "Unit tests completed"
                    }
                }
                stage('Integration Tests') {
                    steps {
                        echo "Running integration tests"
                        sleep 3
                        echo "Integration tests completed"
                    }
                }
                stage('Linting') {
                    steps {
                        echo "Running linting"
                        sleep 5
                        echo "Linting completed"
                    }
                }
                stage('Security Scan') {
                    steps {
                        echo "Running security scan"
                        sleep 4
                        echo "Security scan completed"
                    }
                }
            }
        }
        stage('Deploy') {
            // environment {
            //     ENVIRONMENT = "staging" 
            // }
            // when {
            //     // expression {
            //     //     env.ENVIRONMENT == "staging"  Use expression for complex conditions
            //     // }
            //     params.ENVIRONMENT == "production"
            // }

            steps {
                echo "Deploying the application in ${ENVIRONMENT} environment"
            }
        }
        stage('Notify') {
            steps {
                echo "This build get triggered by ${currentBuild.getBuildCauses()}"
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