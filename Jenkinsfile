pipeline{
    agent {
        docker { image 'docker:dind'}
	}

    stages {
        stage('Test Agent') {
            steps {
                docker build -t frontend:1 front-end/.
            }
        }
    }





}
