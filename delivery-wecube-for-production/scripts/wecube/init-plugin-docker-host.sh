#!/bin/bash

echo "Starting WeCube plugin docker host ..."

echo "remoteHost=$1,password=$2"
echo `pwd`
remoteHost=$1
password=$2

sshpass -p ${password} ssh -o "StrictHostKeyChecking no" root@${remoteHost}  > /dev/null 2>&1 << remoteCmd

yum install docker -y

echo "OPTIONS='-H unix://var/run/docker.sock -H tcp://0.0.0.0:2375'" >> /etc/sysconfig/docker

systemctl start docker.service
systemctl enable docker.service

exit
remoteCmd

echo "Start WeCube plugin docker host success !"