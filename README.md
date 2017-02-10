# Jenkins Slave Machine

This docker image create a Jenkins slave container SSH enabled.
You will be provided with the private key in order to log inside the container.

## Requirement

- Docker Engine installed (`$ docker --version`)
- Docker Compose installed (`$ docker-compose --version`)

### Build the image

Using `docker-compose`:

    $ docker-compose Build

or if you want to use `docker` command

    $ docker build -t jenkins-slave jenkins-slave

### Run the machine (jenkins slave)

    $ docker-compose up -d