pipeline {
  agent any

  tools {
    jdk 'jdk17'
    maven 'maven3'
  }

  environment {
    SCANNER_HOME = tool 'sonar-scanner'
  }

  stages {
    stage('Clean workspace') {
      steps { cleanWs() }
    }

    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build & Test (Maven)') {
      steps {
        dir('demo-app') {
          sh 'mvn -B clean test'
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        dir('demo-app') {
          withSonarQubeEnv('sonar-local') {
            sh '''
              $SCANNER_HOME/bin/sonar-scanner \
                -Dsonar.projectName=esgi-devsecops \
                -Dsonar.projectKey=esgi-devsecops \
                -Dsonar.java.binaries=target/classes
            '''
          }
        }
      }
    }

    stage('Quality Gate') {
      steps {
        waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
      }
    }
  }
}
