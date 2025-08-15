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

    post {
        success {
            script {
                // Pause pipeline until user approves
                def userInput = input(
                    id: 'MergeApproval', 
                    message: 'Do you want to merge test into main?', 
                    ok: 'Submit',
                    parameters: [
                        choice(name: 'Proceed', choices: ['Yes', 'No'], description: 'Approve merge?')
                    ]
                )

                if (userInput == 'Yes') {
                    withCredentials([
                        usernamePassword(credentialsId: 'GitHub_Creds', passwordVariable: 'TOKEN', usernameVariable: 'USER'),
                        string(credentialsId: 'Git_User_Email', variable: 'GIT_USER')
                    ]) {
                        sh """
                            cd /tmp ; git clone https://github.com/marwansss/AngularAPP.git ; cd AngularAPP
                            git config user.name "${USER}"
                            git config user.email "${GIT_USER}"
                            git checkout test ; git checkout main
                            git pull origin main
                            git merge test -m "merge test branch into main"
                            git push https://${USER}:${TOKEN}@github.com/marwansss/AngularAPP.git main
                        """
                    }
                } else {
                    error("Merge to main aborted by user.")
                }
            }
        }
    }
}
