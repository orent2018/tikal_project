# tikal_project
Tikal dockerize app demo
------------------------

A open source project called pystache which is a python implementation of mustache has been chosen
for this demo.

Tools Used
----------

- A jenkins server installed on a ubuntu instance on GCP
- A tikal_project repo was created in github to host the pipeline and build
- A Webhook was created from the repo to the Jenkins server in order to trigger automatic builds on push events.
- A public repo named repo01 has been created in dockerhub to host the published image
- Slack was integrated with the jenkins server in order to send build notifications to a slack channel.


1) The code has been dockerized by cloning the pystache repo and installing pystache on the docker image.

2) Unit tests were run on the pystache image created above

3) After the image has passed the tests it was tagged and pushed to a public repo on dockerhub

4) Notification of the Success or Failure of the pipeline were send to a dedicated slack channel 
   that was integrated with the Jenkins server.
