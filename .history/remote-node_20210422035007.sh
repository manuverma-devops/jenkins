#!/bin/bash

#Check Java Installed or not . . . .  . . . . 

SNAME=$1
USERNAME=$2
PASSWORD=$3

JENKINS_CLIJAR="http://54.237.77.54:8080/jnlpJars/jenkins-cli.jar"

if [ -z "${SNAME}" -o -z "${USERNAME}" -o -z "${PASSWORD}" ]; then 
    echo -e "Correct Usage is  \e[32m sh remote-node.sh AGENT-NAME JenkinsMasteUserName JenkinsMasterPassword \e[0m"
    exit 1
fi 

type java &> /tmp/remote-node.log
if [ $? -ne 0 ] ; then
   yum install java -y &> /tmp/remote-node.log  
else
   echo -n "Already there"
fi

echo -n "Downloading the remote-jar file from master :"
wget ${JENKINS_CLIJAR} &> /tmp/remote-node.log  
if [ $? -ne 0 ] ; then
    echo "Downloaded"  
else
   echo -n "Already there"
fi

echo -n "Updating the Agent Name on agent.XML file"
sed -i -e "s/AGENT-REP/$1" agent.xml 
echo -n "Adding the remote node"
cat agent.xml | java -jar jenkins-cli.jar -auth ${USERNAME}:${PASSWORD} -s http://172.31.48.107:8080/ -webSocket create-node  &> /tmp/remote-node.log 
if [ $? -ne 0 ] ; then
   echo "Node not added check the logs " 
else
   echo -n "Node added"
fi
