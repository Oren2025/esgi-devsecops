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

    stage('clean Workspace') {
      steps {
        cleanWs()
      }
    }

    stage('checkout scm') {
      steps {
        checkout scm
      }
    }

    stage('maven compile') {
      steps {
        sh 'mvn clean compile'
      }
    }

    stage('maven test') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Sonarqube Analysis') {
      steps {
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

    stage('quality gate') {
      steps {
        script {
          waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
        }
      }
    }

  }
}
