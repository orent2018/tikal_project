pipeline {

   agent any 

   environment {
     version_tag= "${env.BUILD_ID}"
   }

   stages {

       stage('Build docker image') {
            steps {
               sh 'docker build -t pystache_alpine .'
            }
    
       }

       stage('Run tests on container from the image created') {
            steps {
               sh 'docker run pystache_alpine pystache-test'
            }
    

       }
       stage('Publish image to docker hub') {
           steps {
             withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]){
                   sh '''
                   docker tag pystache_alpine ${USER}/repo01:pystach_a-${version_tag}
                   docker login --username=${USER} -p ${PASS}
                   docker push ${USER}/repo01:pystach_a-${version_tag}
                   '''
             }
           }
       }
   }
   post {

      success {
         sh 'echo "SUCCESS"'
         slackSend color: 'good',
                   message: "Job ${JOB_NAME} build ${BUILD_NUMBER} has completed successfully"
      }

      failure {
         sh 'echo "FAILURE"'
         slackSend color: 'bad',
                   message: "Job ${JOB_NAME} build ${BUILD_NUMBER} has Failed!!"
      }

   }


}
