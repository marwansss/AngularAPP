pipeline{
    agent {
        docker { image 'docker:dind'}
	}

    stages {
        stage('Test Agent') {
            steps {
				echo "hello from mazo"
                docker build -t frontend:1 front-end/.
            }
        }
    }





}
