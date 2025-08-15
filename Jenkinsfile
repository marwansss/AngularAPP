pipeline{
    agent {
        docker { image 'docker:dind'}
	}

    stages {
        stage('Test Agent') {
            steps {
				dir('front-end') {
    			echo "hello from mazo"
                docker build -t frontend:1 .
}
				
            }
        }
    }





}
