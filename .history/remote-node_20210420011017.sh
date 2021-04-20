#!/bin/bash

#Check Java Installed or not


type java 
if [ $? -ne 0 ] ; then
   echo -e "\e[32m installing Java
   yum install java -y > /tmp/remote-node.log  
   stat $?
else
   echo -n "Java already Installed"
fi