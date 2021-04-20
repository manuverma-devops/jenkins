#!/bin/bash

#Check Java Installed or not


JENKINS_CLIJAR="http://54.237.77.54:8080/jnlpJars/jenkins-cli.jar"

if [ -z ${1} -o -z ${2} -o -z $3} ]; then 
    echo -e"Correct Usage is : \e[32m sh remote-node.sh AGENT-NAME JenkinsMasteUserName JenkinsMasterPassword \e[0m"
    exit 1
fi 

type java 
if [ $? -ne 0 ] ; then
   yum install java -y &> /tmp/remote-node.log  
   stat $?
else
   echo -n "Already there"
fi

echo -n "Downloading the remote-jar file from master :"
curl -s -o  ${JENKINS-CLI-JAR} &> /tmp/remote-node.log  
if [ $? -ne 0 ] ; then
    echo "Downloaded"  
   stat $?
else
   echo -n "Already there"
fi

echo -n "Updating the Agent Name on agent.XML file"
sed -i -e "s/AGENT-REP/${1}" agent.xml 
echo -n "Adding the remote node"
cat agent.xml | java -jar jenkins-cli.jar -auth ${2}:${3} -s http://172.31.48.107:8080/ -webSocket create-node  &> /tmp/remote-node.log 
if [ $? -ne 0 ] ; then
   echo "Node not added check the logs " 
   stat $?
else
   echo -n "Node added"
fi
