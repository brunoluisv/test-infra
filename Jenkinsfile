pipeline {
  agent any
  stages {
    stage('Cloning Infra Repository'){
      steps {
        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/brunoluisv/test-infra.git']], branches: [[name: "*/master"]]],poll: false
      }
    }
    stage('Verify files'){
      steps{
        sh "cat iafox-ingress.yaml"
        sh "cat jobs.yaml"
      }
    }
    stage('Sanity Check'){
      steps{
        input "Seguir para deploy da imagem?"
      }
    }
    stage('Deploy to Kubernetes'){
      steps{
        sh "kubectl apply -f jobs.yaml"
        sh "kubectl apply -f iafox-ingress.yaml"
      }
    }
  }
}
