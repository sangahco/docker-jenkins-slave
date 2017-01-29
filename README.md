# Jenkins Slave Machine

This docker image create a Jenkins slave container SSH enabled.
You will be provided with the private key in order to log inside the container.

## Requirement

- Docker Engine installed
- Docker Compose installed

Start the container with:

    docker-compose up -d

or using Dockerfile:

    docker build 
    docker run -p 8080:8080 -p 50000:50000 -d -v /home/ec2-user/jenkins/var/jenkins_home:/var/jenkins_home jenkins