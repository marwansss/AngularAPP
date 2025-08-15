pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Test Agent') {
            steps {
                sh 'docker build -t frontend:1 front-end/.'
            }
        }
    }
}
