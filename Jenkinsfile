pipeline {
  agent any
    stage('Cloning Infra Repository'){
      steps {
        checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/brunoluisv/test-infra.git']], branches: [[name: "*/master"]]],poll: false
      }
    }
    stage('Generate jobs.yaml'){
      steps {
        sh "cat iafox.yaml.jinja2 | render_template > jobs.yaml"
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
