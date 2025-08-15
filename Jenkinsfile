pipeline {
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
                    withCredentials([usernamePassword(credentialsId: 'DockerHub_Creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh """
                            docker build -t maro4299311/inspirehub-jenkins-dynamic-agent:${BUILD_NUMBER} .
                            docker login -u ${USER} -p ${PASS}
                            docker push maro4299311/inspirehub-jenkins-dynamic-agent:${BUILD_NUMBER}
                        """
                    }
                }
            }
        }
    }

	

	post{
		success{
			script{
				withCredentials([usernamePassword(credentialsId: 'GitHub_Creds', passwordVariable: 'TOKEN', usernameVariable: 'USER')]) {
				    sh '''
					git config user.name "${USER}"
					withCredentials([string(credentialsId: 'Git_User_Email', variable: 'GIT_USER')]) {
					    git config user.email "${GIT_USER}"
					}
					git checkout main
					git pull origin main
					git merge test -m "merge test branch into main"
					git push https://${USER}:${TOKEN}@github.com/marwansss/AngularAPP.git main
				    '''
				}

			}
	



		}

	}


}
