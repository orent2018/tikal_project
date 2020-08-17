# tikal_project
Tikal dockerize app demo
------------------------

A open source project called pystache which is a python implementation of mustache has been chosen
for this demo.

Tools Used
----------

- A jenkins server was installed on a ubuntu instance created on GCP.
- Docker Engine was installed on the ubuntu box and the jenkins user added to the docker group.
- A tikal_project repo was created in github to host the pipeline and build.
- A Webhook was created from the repo to the Jenkins server in order to trigger automatic builds on push events.
- A public repo named repo01 has been created in dockerhub to host the published image
- Slack was integrated with the jenkins server in order to send build notifications to a slack channel.
- Credentials for slack and dockerhub were created in the jenkins servers to avoid plan text passwords and secrets.

Trigger for pipeline
--------------------
 - Any push event to this repository will trigger the pipeline job to run.

Pipeline Steps
--------------

1) The code has been dockerized by cloning the pystache repo and installing pystache on the docker image.
   For the source image used in this project, 3 types were tested.  A ubuntu,python2-slim and python2-alpha.

   The resulting image sizes were:

                               ubuntu 460MB

                               slim   260MB 

                               alpha   95MB
  

   The lightest image worked well and was chosen.  The build was performed with the following command:

     $docker build -t pystache_alpine .

2) Unit tests were run on the pystache image created above:

     $docker run pystache_alpine pystache-test
   

3) After the image has passed the tests it was tagged and pushed to a public repo on dockerhub:

     $docker tag pystache_alpine ${USER}/repo01:pystach_a-${version_tag}

     $docker login --username=${USER} -p ${PASS}

     $docker push ${USER}/repo01:pystach_a-${version_tag}

4) Notification of the Success or Failure of the pipeline were send to a dedicated slack channel 
   that was integrated with the Jenkins server.
   
   The slack channel is #jenkins-build-output in oren-inc workspace

   In order to see the channel one has to be invited to the oren-inc workspace and added to the channel.

