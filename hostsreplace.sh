#!/bin/bash

#This script is designed to circumvent DNS by automatically picking up the a record of archive.ubuntu.com

hash=$(dig archive.ubuntu.com a | grep -A 1 "ANSWER SECTION" | grep "IN" | awk '{print$5}');
HOST=$(cat /etc/hosts | grep archive.ubuntu.com | awk '{print$2}');

if [ -z "$hash" ];
  then echo "Nope, it's messed up. Sorry."
  exit
fi

if [ -z "$HOST" ];
  then echo $hash "  archive.ubuntu.com" >> /etc/hosts
fi
