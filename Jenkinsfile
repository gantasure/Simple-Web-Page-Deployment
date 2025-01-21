pipeline {
    agent any
    triggers {
        githubPush()
    }
    stages {
        stage('Build Docker Image') {
            steps {
                git branch: 'main', url: 'your_git_repo_url' # Replace with your repo URL
                sh 'docker build -t simple-web-page .'
            }
        }
        stage('Push to Docker Hub (Optional)') {
            when {
                expression { return env.BRANCH_NAME == 'main' }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker login -u $USERNAME -p $PASSWORD"
                    sh 'docker tag simple-web-page:latest your_dockerhub_username/simple-web-page:latest' # Replace with your Docker Hub username
                    sh 'docker push your_dockerhub_username/simple-web-page:latest'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'ec2-server',
                                                            transfers: [sshTransfer(cleanRemote: false,
                                                                                 excludes: '',
                                                                                 execCommand: '''
                                                                                     #!/bin/bash
                                                                                     docker stop simple-web-page || true
                                                                                     docker rm simple-web-page || true
                                                                                     docker pull your_dockerhub_username/simple-web-page:latest || true # Or just simple-web-page if not using Docker Hub
                                                                                     docker run -d -p 80:80 --name simple-web-page your_dockerhub_username/simple-web-page:latest
                                                                                     echo "Deployment Complete"
                                                                                 ''',
                                                                                 flatten: false,
                                                                                 makeEmptyDirs: false,
                                                                                 noDefaultExcludes: false,
                                                                                 remoteDirectory: '/home/ubuntu',
                                                                                 removePrefix: '',
                                                                                 sourceFiles: '')],
                                                            usePromotion: false,
                                                            useRetry: false)],
                             continueOnError: false,
                             failOnError: true,
                             hostKeyAlias: '',
                             publishEvenIfNothingToTransfer: false,
                             retryTimes: 0,
                             timeout: 120000)
            }
        }
    }
}
