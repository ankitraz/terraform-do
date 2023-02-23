pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building..."'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing..."'
            }
        }

        stage('provision server') {
            environment{
                ssh_key = credentials('do-public-key')
            }
            steps {
                sh 'echo "provisioning server..."'
                withCredentials([string(credentialsId: 'do-api-key', variable: 'DO_API_KEY')]) {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve -var "do_token=${DO_API_KEY}" -var "ssh_key=${ssh_key}"'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deploying..."'
            }
        }
    }
}
