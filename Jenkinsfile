pipeline {

    agent any

    tools {
        go 'go1.14'
    }
    environment {
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
    }

    stages {
        stage("SonarQube Analysis") {
            steps {
                script {
                    def scannerHome = tool 'SonarQubeScanner-4.8.0';
                    withSonarQubeEnv("sonarqube-9.8") {
                         sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }


        stage("unit-test") {
            steps {
                echo 'UNIT TEST EXECUTION STARTED'
                sh 'make unit-tests'
            }
        }
        // stage("functional-test") {
        //     steps {
        //         echo 'FUNCTIONAL TEST EXECUTION STARTED'
        //         sh 'make functional-tests'
        //     }
        // }
        stage("build") {
            steps {
                echo 'BUILD EXECUTION STARTED'
                sh 'go version'
                sh 'go get ./...'
                sh 'docker build . -t rahul0024/service_sonar'
            }
        }
        stage('Docker Push') {
            agent any
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerhubPassword', usernameVariable: 'dockerhubUser')]) {
                sh "docker login -u ${env.dockerhubUser} -p ${env.dockerhubPassword}"
                sh 'docker push rahul0024/service_sonar'
                }
            }
        }
    }
}
