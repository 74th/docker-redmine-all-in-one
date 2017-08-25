pipeline {
  agent any
  triggers {
    cron('H H * * *')
  }
  stages {
    stage('build') {
      steps {
        sh 'make build'
      }
    }
  }
}
