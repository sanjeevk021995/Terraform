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
         terraform init -backend-config="access_key=$AWS_ACCESS_KEY_ID_PP"   -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY_PP"  -backend-config="role_arn=$AWS_ROLE_ARN_PP" 
          terraform workspace select ${ENV}
          terraform workspace show
          
          if [[ ${terraform_action} == "init" ]];
          then
                 pwd && terraform init -backend-config="access_key=$AWS_ACCESS_KEY_ID_PP"   -backend-config="secret_key=$AWS_SECRET_ACCESS_KEY_PP"  -backend-config="role_arn=$AWS_ROLE_ARN_PP" 
          elif [[ ${terraform_action} == "plan" ]];
          then
                 pwd && terraform plan 
          elif [[ ${terraform_action} == "apply" ]];
          then
                pwd && terraform apply --auto-approve 
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

