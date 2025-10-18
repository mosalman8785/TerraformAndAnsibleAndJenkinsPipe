pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('aws-cred')
        SSH_KEY = credentials('ec2-key')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mosalman8785/TerraformAndAnsibleAndJenkinsPipe.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh '''
                terraform init
                terraform apply -auto-approve \
                    -var "aws_access_key=${AWS_CREDENTIALS_USR}" \
                    -var "aws_secret_key=${AWS_CREDENTIALS_PSW}"
                '''
            }
        }

        stage('Get EC2 Public IP') {
            steps {
                script {
                    EC2_IP = sh(script: "terraform output -raw public_ip", returnStdout: true).trim()
                    echo "EC2 Public IP: ${EC2_IP}"
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                writeFile file: 'inventory', text: "${EC2_IP} ansible_user=ubuntu ansible_ssh_private_key_file=${SSH_KEY}"
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}
