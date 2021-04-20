#!/bin/bash

#Check Java Installed or not

stat
type java 
if [ $? -ne 0 ] ; then
   yum install java -y > /tmp/remote-node.log  
   stat $?
else
   echo -n "Java already Installed"
fi