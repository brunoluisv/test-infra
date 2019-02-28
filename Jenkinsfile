pipeline {
  agent any
  stages {
    stage('Cloning Infra Repository'){
      steps {
        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/brunoluisv/test-infra.git']], branches: [[name: "*/master"]]],poll: false
      }
    }
    stage('Execute scripts | jinja2 && ingress'){
      steps{
      sh '''
        alias render_template='python -c "from jinja2 import Template; import sys; print(Template(sys.stdin.read()).render());"'
        cat iafox-test.yaml.jinja2 | render_template > iafox-deploys.yaml
        ./script-to-ingress.sh
      '''
      }
    }
    stage('Verify files'){
      steps {
        sh "cat iafox-deploys.yaml"
        sh "cat iafox-ingress.yaml"
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
