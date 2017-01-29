FROM openjdk:8-jdk

ARG user=remote
ENV REMOTE_HOME /home/${user}

USER root
RUN apt-get update && apt-get install -y \
    openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -d "$REMOTE_HOME" -m -s /bin/bash ${user}
#USER ${user}
RUN mkdir $REMOTE_HOME/.ssh
COPY jenkins_dsa.pub $REMOTE_HOME/.ssh/

WORKDIR $REMOTE_HOME
RUN set -x \
    && chmod 700 .ssh \
    && touch .ssh/authorized_keys \
    && chmod 600 .ssh/authorized_keys \
    && cat .ssh/jenkins_dsa.pub >> .ssh/authorized_keys \
    && rm .ssh/jenkins_dsa.pub \
    && chown -R ${user} .ssh \
    && mkdir -p /var/run/sshd

COPY sshd_config ./etc/ssh/

EXPOSE 22

VOLUME "$REMOTE_HOME/jenkins"

CMD ["/usr/sbin/sshd", "-D"]