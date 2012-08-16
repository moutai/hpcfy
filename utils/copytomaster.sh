#!/bin/bash

filename=$1

ssh root@`head -1 hosts | cut -d " " -f1` 'cat  /root/.ssh/authorized_keys >> /home/hpcuser/.ssh/authorized_keys'
scp -r $filename hpcuser@`head -1 hosts | cut -d " " -f1`:~/

  
