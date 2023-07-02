pipeline {
    environment {
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
            image: hashicorp/terraform
            command:
            - bin/cat
            tty: true
            env:
            - name: AWS_ACCESS_KEY_ID
              value: $env.hashicorp/terraform
            - name: AWS_SECRET_ACCESS_KEY
              value: $env.AWS_SECRET_ACCESS_KEY
        '''
    }
  }
  stages {
      stage('checkout'){
          steps{
             checkout scmGit(branches: [[name: '*/main']], extensions: [], 
                             userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sanjeevk021995/Terraform.git']])
          }
      }
    stage('Run terraform') {
      steps {
        container('terraform') {
          sh 'terraform init'
          sh 'terraform plan -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"'
          sh 'terraform apply --auto-approve -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"'
          sh 'terraform state push -force "s3://sample-dev-env-state/terraform.tfstate"'
        }
      }
    }



  }
}
