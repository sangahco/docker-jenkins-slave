FROM openjdk:8-jdk

ARG user=slave
ENV REMOTE_HOME /home/${user}
ENV JAVA_OPTS="-Duser.timezone=GMT"

COPY . /usr/local/src

USER root
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
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
    && cp /usr/local/src/docker-entrypoint.sh /entrypoint.sh \
    && curl https://bootstrap.pypa.io/get-pip.py -o /usr/local/src/get-pip.py \
    && python3 /usr/local/src/get-pip.py --user \
    && ~/.local/bin/pip install awscli --upgrade --user \
    && rm -rf /usr/local/src

EXPOSE 22

WORKDIR $REMOTE_HOME

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]