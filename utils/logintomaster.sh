ssh root@`head -1 hosts | cut -d " " -f1` 'cat  /root/.ssh/authorized_keys >> /home/hpcuser/.ssh/authorized_keys'
ssh hpcuser@`head -1 hosts | cut -d " " -f1`
