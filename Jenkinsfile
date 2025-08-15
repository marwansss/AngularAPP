pipeline{
    agent {
        docker { image 'node:16-alpine'}
	}

    stages {
        stage('Test Agent') {
            steps {
				dir('front-end') {
    			sh 'node --version'
}
				
            }
        }
    }





}
