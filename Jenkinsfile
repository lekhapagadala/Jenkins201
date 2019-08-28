def dockerImage
pipeline {
  environment {
    registry = "kdeepak233/devops"
    registryCredential = 'Deep@7167'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/kdeepak233/devops.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }
    stage("Remove all existing containers"){
        steps{
            sh 'docker ps -a -q |xargs -r docker rm -f'
        }
    }
    stage("Running the new Image"){
        steps{
            sh 'docker run -p 80:9090 -d kdeepak233/devops:$BUILD_NUMBER'
        }
    }
  }
}