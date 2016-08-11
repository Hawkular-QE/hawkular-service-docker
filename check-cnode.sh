#!/bin/bash

if [ -z ${1} ]; then
   echo "Missing Cassandra node address"
   exit 1
fi
   
while : ; do
   timeout 5 nc -w 2 $1 9160 > /dev/null 2>&1
   status=$?
   if [[ $status -eq 2 ]]; then
     echo "Invalid host"
     exit 2
   fi 

   if [[ $status -eq 124 || $status -eq 0 ]]; then
     echo "DB service online"
     exit 0
   fi
done

exit 124
