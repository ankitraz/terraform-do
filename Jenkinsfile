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
                script{
                    sh 'echo "provisioning server..."'
                withCredentials([string(credentialsId: 'do-api-key', variable: 'DO_API_KEY')]) {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve -var "do_token=${DO_API_KEY}" -var "ssh_key=${ssh_key}"'
                    sh 'terraform output droplet_ip'
                    def droplet_ip = sh(returnStdout: true, script: 'terraform output droplet_ip').trim()
                    withEnv(['DROPLET_IP=' + dropletIp]) {
        // Execute any further steps that require the droplet IP address
        // For example, SSH into the droplet to run some commands
                    
                }
                    // sh 'terraform destroy -auto-approve -var "do_token=${DO_API_KEY}" -var "ssh_key=${ssh_key}"'
                }
                }
            }
        }
        stage('Deploy') {
            steps {
                script{
                    sh 'echo "Deploying..."'
                sh 'echo "Deploying to ${droplet_ip}"'
                sh 'ssh -o StrictHostKeyChecking=no root@${DROPLET_IP} "echo hello world"'
                }
                
            }
        }
    }
}
