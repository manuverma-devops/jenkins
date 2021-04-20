#!/bin/bash

#Check Java Installed or not

JENKINS-CLI-JAR="http://54.237.77.54:8080/jnlpJars/jenkins-cli.jar"

type java 
if [ $? -ne 0 ] ; then
   echo -e "\e[32m installing Java\e[0m]"
   yum install java -y &> /tmp/remote-node.log  
   stat $?
else
   echo -n "Success"
fi

echo -n "Downloading the remote-jar file from master"
wget ${JENKINS-CLI-JAR} &> /tmp/remote-node.log  

