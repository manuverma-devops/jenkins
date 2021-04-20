#!/bin/bash

#Check Java Installed or not


if [ ${}1]

fi 

JENKINS-CLI-JAR="http://54.237.77.54:8080/jnlpJars/jenkins-cli.jar"

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
cat agent.xml | java -jar jenkins-cli.jar -auth ${2}:${3} -s http://172.31.48.107:8080/ -webSocket create-node