FROM openjdk:8-jdk

ARG user=slave
ENV REMOTE_HOME /home/${user}

COPY . /usr/local/src

USER root
RUN apt-get update && apt-get install -y \
    openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && useradd --home "$REMOTE_HOME" --create-home --shell /bin/bash ${user} \
    && cd $REMOTE_HOME \
    && mkdir .ssh && chmod 700 .ssh \
    && touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys \
    && cat /usr/local/src/jenkins_dsa.pub >> .ssh/authorized_keys \
    && chown -R ${user}: .ssh \
    && mkdir -p /var/run/sshd \
    && cp /usr/local/src/sshd_config /etc/ssh \
    && rm -rf /usr/local/src

EXPOSE 22

WORKDIR $REMOTE_HOME

CMD ["/usr/sbin/sshd", "-D"]