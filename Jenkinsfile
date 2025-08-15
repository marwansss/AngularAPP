pipeline{
    agent {
        docker {
        image 'docker:dind'
        args '-u root:root --privileged'
    }
	}

    stages {
        stage('Build Frontend App') {
            steps {
				dir('front-end') {
    			sh '''
					docker build -t maro4299311/inspirehub-jenkins-dynamic-agent:${BUILD_NUMBER} .
	 				withCredentials([usernamePassword(credentialsId: 'DockerHub_Creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
					    docker login -u ${USER} -p ${PASS}
					}
					docker push maro4299311/inspirehub-jenkins-dynamic-agent:${BUILD_NUMBER}


				'''
					
}
				
            }
        }
    }





}
