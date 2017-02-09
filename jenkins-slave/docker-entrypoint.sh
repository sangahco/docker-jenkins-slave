#!/usr/bin/env bash

set -e

PROXY_SSH_KEY=sadev.key
PROXY_HOST=dev.sangah.com
PROXY_USER=sangah
SVN_HOST=125.141.221.126

echo "------------------------------------------------"
echo "Jenkins Slave Settings:"
echo "- Proxy SSH Key=$PROXY_SSH_KEY"
echo "- Proxy Host=$PROXY_HOST"
echo "- Proxy User=$PROXY_USER"
echo "- Proxy AWS S3 Proxy SSH Key=$AWS_S3_PROXY_SSH_KEY"
echo "------------------------------------------------"

if [ "$AWS_S3_PROXY_SSH_KEY" != "" ]; then
    export AWS_DEFAULT_REGION=ap-northeast-2
    export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?missing}
    export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?missing}
    export AWS_S3_PROXY_SSH_KEY=${AWS_S3_PROXY_SSH_KEY:?missing}
    ~/.local/bin/aws s3 cp s3://${AWS_S3_PROXY_SSH_KEY} /etc/ssl/private/$PROXY_SSH_KEY
fi

chmod 0600 /etc/ssl/private/$PROXY_SSH_KEY
ssh -f -o StrictHostKeyChecking=no -N -i /etc/ssl/private/$PROXY_SSH_KEY -L 9001:${SVN_HOST}:80 ${PROXY_USER}@${PROXY_HOST}

exec /usr/sbin/sshd -D