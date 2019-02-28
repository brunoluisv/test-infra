pipeline {
  agent any
  stages {
    stage('Cloning Infra Repository'){
      steps {
        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/brunoluisv/test-infra.git']], branches: [[name: "*/master"]]],poll: false
      }
    }
    stage('Generate jobs.yaml'){
      steps {
        alias render_template='python -c "from jinja2 import Template; import sys; print(Template(sys.stdin.read()).render());"'
        sh "cat iafox-test.yaml.jinja2 | render_template > jobs.yaml"
      }
    }
    stage('Generate ingress'){
      steps {
        sh "./script-to-ingress.sh"
        sh "ls"
      }
    }
  }
}
