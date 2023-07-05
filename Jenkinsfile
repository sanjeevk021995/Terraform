pipeline {
    environment {
        role_path = "./roles/"
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_ROLE_ARN = credentials('AWS_ROLE_ARN')
    }
agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: terraform
            image: hashicorp/terraform:1.5
            command:
            - bin/cat
            tty: true
            resources:
              requests:
                memory: "556Mi"
                cpu: "400m"
            env:
            - name: AWS_ACCESS_KEY_ID
              value: $env.hashicorp/terraform
            - name: AWS_SECRET_ACCESS_KEY
              value: $env.AWS_SECRET_ACCESS_KEY
        '''
    }
  }

  stages {
     /* stage('checkout'){
          steps{
             checkout scmGit(branches: [[name: 'main']], extensions: [], 
                             userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sanjeevk021995/Terraform.git']])
          }
      }*/
      
stage('terraform init'){
     steps { 
       script{
        container('terraform') {
        sh '''
          if [[ ${resources} == "roles" ]];
          then
                 cd ${role_path} && pwd && terraform init
                 pwd
          else 
                 terraform init && pwd
          fi
          '''
        }
        }
       }
      }
stage('terraform plan') {
      steps {
        script{
        container('terraform') {
        sh '''
          if [[ ${terrafrom_action} == "plan" && ${resources} == "roles" ]];
          then
                 pwd
                 cd ${role_path} && pwd && terraform ${terraform_action} -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          else
                 terraform ${terraform_action} -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          fi
          '''
        }
      }
    }
   }

      
  }
  }

