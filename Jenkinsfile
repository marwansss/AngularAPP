pipeline{
    agent {
        label 'inspirehub-agent'
	}

    stages {
        stage('Test Agent') {
            steps {
                sh 'whoami'
                sh 'docker --version'
                sh 'node --version'
                sh 'npm --version'
            }
        }
    }





}
