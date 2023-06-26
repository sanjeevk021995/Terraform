pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: terrafrom
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
    stage('Run terraform') {
       // agent { label "jenkins-slave"}
      steps {
        container('terraform') {
          sh 'terraform version'
        }
      }
    }
  }
}
