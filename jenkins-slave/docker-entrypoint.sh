#!/usr/bin/env bash

set -e

PROXY_SSH_KEY=sadev.key
PROXY_HOST=dev.sangah.com
PROXY_USER=sangah
SVN_HOST=125.141.221.126

if [ "$AWS_S3_SVN_SSH_KEY" != "" ]; then
    AWS_DEFAULT_REGION=ap-northeast-2
    AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?missing}
    AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?missing}
    AWS_S3_SVN_SSH_KEY=${AWS_S3_SVN_SSH_KEY:?missing}

    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    unzip awscli-bundle.zip
    ./awscli-bundle/install -b ~/bin/aws
    ~/bin/aws s3 cp s3://${AWS_S3_SVN_SSH_KEY} /etc/ssl/private/$PROXY_SSH_KEY
    chmod 0600 /etc/ssl/private/$PROXY_SSH_KEY
    ssh -f -N -i /etc/ssl/private/$PROXY_SSH_KEY -L 9001:${SVN_HOST}:80 ${PROXY_USER}@${PROXY_HOST}
fi

exec /usr/sbin/sshd -D