def dockerImage
pipeline {
  environment {
    registry = "avi4010/maven-webapp-project"
    registryCredential = 'dockerhub'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/avi4010/maven-webapp-project.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          //docker.build registry + ":$BUILD_NUMBER" + " --no-cache"
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          //dockerImage = docker.build (registry + ":$BUILD_NUMBER", " --no-cache .")
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
            sh 'docker run -p 80:9090 -d avi4010/maven-webapp-project:$BUILD_NUMBER'
        }
    }
  }
}