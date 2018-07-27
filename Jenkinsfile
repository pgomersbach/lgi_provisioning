pipeline {
  agent any
  stages {
    stage('Dependencies') {
      steps {
        sh 'cd $WORKSPACE'
        sh 'mkdir -p doc'
      }
    }
    stage('Dependencies TF') {
      parallel {
        stage('Dependencies TF') {
          steps {
            sh '''curl https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -s -o /tmp/terraform_0.11.7_linux_am
d64.zip'''
            sh 'unzip -o -q /tmp/terraform_0.11.7_linux_amd64.zip -d $WORKSPACE'
          }
        }
        stage('Dependencies TF_docs') {
          steps {
            sh '''curl https://github.com/segmentio/terraform-docs/releases/download/v0.3.0/terraform-docs_linux_amd64 -L -s -o $WORKSPACE/t
erraform-docs'''
            sh 'chmod +x $WORKSPACE/terraform-docs'
          }
        }
      }
    }
  }
}