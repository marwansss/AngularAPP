pipeline{
    agent {
        docker { image 'docker:dind'}
	}

    stages {
        stage('Test Agent') {
            steps {
				dir('front-end') {
    			sh 'echo "hello from mazo"'
                sh 'docker build -t frontend:1 .'
}
				
            }
        }
    }





}
