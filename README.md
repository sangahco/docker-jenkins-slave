# Jenkins Slave Machine

This docker image create a Jenkins slave container SSH enabled.
You will be provided with the private key in order to log inside the container.

> ---
**For the SVN Tunnel to work you need to provide the following variables:**

- `AWS_ACCESS_KEY_ID` - The AWS Access Key
- `AWS_SECRET_ACCESS_KEY` - The AWS Secret Key 
- `AWS_S3_PROXY_SSH_KEY` - The location of the private ssl key on Amazon S3 in order to access the proxy machine

You can edit the file ~/.bashrc and add the following code:

    export AWS_S3_PROXY_SSH_KEY=sangah-b1/ssl/sadev_jenkins.key
    export AWS_ACCESS_KEY_ID=****
    export AWS_SECRET_ACCESS_KEY=**************

> ---

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