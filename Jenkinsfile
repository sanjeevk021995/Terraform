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
      stage('checkout'){
          steps{
             checkout scmGit(branches: [[name: '*/main']], extensions: [], 
                             userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sanjeevk021995/Terraform.git']])
          }
      }
      
      stage('aws-cli'){
           agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: aws-cli
            image: amazon/aws-cli:2.12.6
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
  steps {
        container('aws-cli') {
          sh '''
         aws configure --profile terraform && aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile terraform && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET" --profile terraform && aws configure set region 'us-east-2' --profile user2 && aws configure set output "table" --profile user2
         '''
        }
        }
          }
      
    stage('Run terraform') {
      steps {
        container('terraform') {
          sh 'terraform init -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"'
          sh 'terraform plan -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"'
          sh 'terraform apply --auto-approve -var "AWS_ROLE_ARN=$AWS_ROLE_ARN"'
       
        }
      }
    }
  }
}
