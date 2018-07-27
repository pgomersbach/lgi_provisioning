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
            sh 'curl https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip -s -o /tmp/terraform_0.11.7_linux_amd64.zip'
            sh 'unzip -o -q /tmp/terraform_0.11.7_linux_amd64.zip -d $WORKSPACE'
            sh '$WORKSPACE/terraform init'
          }
        }
        stage('Dependencies TF_docs') {
          steps {
            sh 'curl https://github.com/segmentio/terraform-docs/releases/download/v0.3.0/terraform-docs_linux_amd64 -L -s -o $WORKSPACE/terraform-docs'
            sh 'chmod +x $WORKSPACE/terraform-docs'
          }
        }
        stage('Dependencies pandoc') {
          steps {
            sh 'curl https://github.com/jgm/pandoc/releases/download/2.2.2.1/pandoc-2.2.2.1-linux.tar.gz -L -s -o $WORKSPACE/pandoc-2.2.2.1-linux.tar.gz'
            sh 'tar zxf $WORKSPACE/pandoc-2.2.2.1-linux.tar.gz'
          }
        }
      }
    }
    stage('Code quality TF') {
      parallel {
        stage('Code quality TF') {
          steps {
            echo 'placeholder'
          }
        }
        stage('Code quality packer') {
          steps {
            echo 'place holder'
          }
        }
        stage('Code quality ansible') {
          steps {
            echo 'placeholder'
          }
        }
      }
    }
  }
}