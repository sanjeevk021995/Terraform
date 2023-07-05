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
    /*when {
        expression {
        ${terraform_action} == "plan" 
        }
    }*/
      steps {
        script{
        container('terraform') {
        sh '''
          if [[ ${terraform_action} == "plan" && ${resources} == "roles" ]];
          then
                 pwd
                 cd ${role_path} && pwd && terraform ${terraform_action} -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          elif [[ ${terraform_action} == "plan" && ${resources} == "s3" ]];
          then
                 pwd && cd && ls -l && terraform ${terraform_action} -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          else
                echo "moving to terraform apply"
          fi
          '''
        
        }
      }
    }
   }

      stage('terraform action') {
      steps {
        script{
        container('terraform') {
        sh '''
          if [[ ${terraform_action} == "apply" && ${resources} == "roles" || ${terraform_action} == "destroy" && ${resources} == "roles" ]];
          then
                 pwd
                 cd ${role_path} && pwd && terraform ${terraform_action} --auto-approve -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          elif [[ ${terraform_action} == "apply" || ${terraform_action} == "destroy" ]];
          then
                 terraform plan && terraform ${terraform_action} --auto-approve -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"
          else 
                 echo "skipping the terraform action only plan is executed"
          fi
          '''
        }
      }
    }
   }
      
  }
  }

