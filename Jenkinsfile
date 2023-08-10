pipeline {
    environment {
        role_path = "./roles/"
        AWS_ACCESS_KEY_ID_PP    = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY_PP = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_ROLE_ARN_PP = credentials('AWS_ROLE_ARN')

      //  AWS_ACCESS_KEY_ID_P    = credentials('AWS_ACCESS_KEY_ID_P')
        //AWS_SECRET_ACCESS_KEY_P = credentials('AWS_SECRET_ACCESS_KEY_P')
        //AWS_ROLE_ARN_P = credentials('AWS_ROLE_ARN_P')
    }
agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: terraform-preprod
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
              value: $env.AWS_ACCESS_KEY_ID_PP
            - name: AWS_SECRET_ACCESS_KEY
              value: $env.AWS_SECRET_ACCESS_KEY_PP
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
      

stage('terraform preprod') {

      steps {
        script{
        container('terraform-preprod') {
            if ( "${ENV}" == "preprod") {
        sh '''
          cd ${role_path}
          terraform workspace new ${ENV}
          terraform workspace show
          terraform init
          if [[ ${terraform_action} == "init" ]];
          then
                 pwd && terraform init -reconfigure
          elif [[ ${terraform_action} == "plan" ]];
          then
                 pwd && terraform plan -var "AWS_ROLE_ARN=$AWS_ROLE_ARN_PP"
          elif [[ ${terraform_action} == "apply" ]];
          then
                pwd && terraform apply --auto-approve -var "AWS_ROLE_ARN=$AWS_ROLE_ARN_PP"
          else
                echo "select correct option"      
          fi
          '''

            }
        }
      }
    }
   }
      
  }
  }

