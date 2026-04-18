@Library('my_shared_library@main') _

pipeline {
    agent any 

    environment {
        BUILD_TOOL = 'CI/CD'
        APP_NAME = 'jenkins'
        IMAGE_NAME = 'amandabral9954/jenkins-in-practice'
    }

    parameters {
        string(name: 'APP_VERSION', defaultValue: '1.0', description: 'Application version')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Environment')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'RUN_TESTS')
    }

    stages {
        stage('Build') {
            steps {
                buildApp(
                    appName: env.APP_NAME.toUpperCase(),
                    buildTool: env.BUILD_TOOL,
                    appVersion: params.APP_VERSION,
                    environment: params.ENVIRONMENT
                )
            }
        }
        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sh 'echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin'
                
                dockerBuildPush(
                    imageName: env.IMAGE_NAME,
                    imageTag: params.APP_VERSION,
                    credentialsId: 'dockerhub_creds'
                    )
            }
            }
        }
        stage('Test') {

            when {
                    expression { params.RUN_TESTS }
                }
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

            when {
                expression { params.ENVIRONMENT == "prod"}
            }

            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    input message: 'Deploy to production?', ok: 'yes'
                }
                
                echo "Deploying the application in ${params.ENVIRONMENT} environment"
            }
        }
        stage('Notify') {
            steps {
                runTests(params.RUN_TESTS)
                echo "This build get triggered by ${currentBuild.getBuildCauses()}"
                echo "Choosen environment is ${params.ENVIRONMENT}"
                echo "App version is ${params.APP_VERSION}"
                notifyBuild(currentBuild.result ?: 'SUCCESS')
            }
        }
    }

    post {
        always {
            echo "Pipeline completed"
            sh "docker rmi ${IMAGE_NAME}:${APP_VERSION} || true"
            sh "docker rmi ${IMAGE_NAME}:latest || true"
            sh 'docker logout'
        }

        failure {
            echo "Pipeline failed"
        }

        success {
            echo "Pipeline succeeded"
        }
    }
}