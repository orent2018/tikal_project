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
             sh 'docker tag pystache_alpine repo01/pystach_a:${version_tag}'
             withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]){
             //      docker tag pystache_alpine repo01/pystach_a:${version_tag}
                   sh '''
                   docker login --username=${USER} -p ${PASS}
                   '''
             //      docker push repo01/pystach_a:${version_tag}
             }
              sh '''
                echo "Publish phase"
              '''
           }
       }
   }
   post {

      success {
         sh 'echo "SUCCESS"'
/*       mail to: 'orent66@gmail.com',
         subject: "Job '${env.JOB_NAME}' (${BUILD_NUMBER}) has completed!"
         body: " Job ${JOB_NAME} has completed successfully"
*/
      }

      failure {
         sh 'echo "FAILURE"'
/*       mail to: 'orent66@gmail.com',
         subject: "Job '${env.JOB_NAME}' (${BUILD_NUMBER}) has Failed"
         body: " Job ${JOB_NAME} (${BUILD_NUMBER}) has failed!"
*/
      }

   }


}
