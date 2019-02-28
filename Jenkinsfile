pipeline {
  agent any
  stages {
    stage('Cloning Infra Repository'){
      steps {
        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/brunoluisv/test-infra.git']], branches: [[name: "*/master"]]],poll: false
      }
    }
    stage(bla){
      steps{
      sh '''
        alias render_template='python -c "from jinja2 import Template; import sys; print(Template(sys.stdin.read()).render());"'
        cat job.yaml.jinja2 | render_template > jobs.yaml
      '''
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
