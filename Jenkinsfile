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
                office365ConnectorSend color: 'yellow', message: 'Build is pause for job ${env.JOB_NAME}  ${env.BUILD_NUMBER}, Do you want to merge to main branch?', status: 'Pause', webhookUrl: 'https://studentaast.webhook.office.com/webhookb2/0144e8ac-3087-4406-be09-a6ec21292341@a86ca211-c918-4c77-8b32-440c27aa3100/JenkinsCI/a4c1dc8759fb412098d84efe2f3fcbbe/73c1338e-797f-4660-a125-df8602df4da7/V2jYWaJbgZz0-N0QI7bzi3bOpGgm8zDhOLeoesRqJdkX01'

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
                        office365ConnectorSend color: 'green', message: 'Merging is Success for job ${env.JOB_NAME}  ${env.BUILD_NUMBER}', status: 'Success', webhookUrl: 'https://studentaast.webhook.office.com/webhookb2/0144e8ac-3087-4406-be09-a6ec21292341@a86ca211-c918-4c77-8b32-440c27aa3100/JenkinsCI/a4c1dc8759fb412098d84efe2f3fcbbe/73c1338e-797f-4660-a125-df8602df4da7/V2jYWaJbgZz0-N0QI7bzi3bOpGgm8zDhOLeoesRqJdkX01'
                    }
                } else {
                    error("Merge to main aborted by user.")
                    office365ConnectorSend color: 'red', message: 'Merging is fail for job ${env.JOB_NAME}  ${env.BUILD_NUMBER}', status: 'Failed', webhookUrl: 'https://studentaast.webhook.office.com/webhookb2/0144e8ac-3087-4406-be09-a6ec21292341@a86ca211-c918-4c77-8b32-440c27aa3100/JenkinsCI/a4c1dc8759fb412098d84efe2f3fcbbe/73c1338e-797f-4660-a125-df8602df4da7/V2jYWaJbgZz0-N0QI7bzi3bOpGgm8zDhOLeoesRqJdkX01'
                }
            }
        }
        failure{
            script{
                office365ConnectorSend color: 'red', message: 'Pipeline Build failed for job ${env.JOB_NAME}  ${env.BUILD_NUMBER}', status: 'Failed', webhookUrl: 'https://studentaast.webhook.office.com/webhookb2/0144e8ac-3087-4406-be09-a6ec21292341@a86ca211-c918-4c77-8b32-440c27aa3100/JenkinsCI/a4c1dc8759fb412098d84efe2f3fcbbe/73c1338e-797f-4660-a125-df8602df4da7/V2jYWaJbgZz0-N0QI7bzi3bOpGgm8zDhOLeoesRqJdkX01'
            }
        }
    }
}
