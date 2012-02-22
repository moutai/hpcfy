#!/bin/bash
# Proper header for a Bash script.
#pwd;
#git add ../.;

#git commit -a; 
#git push; 


ssh mtaifi@tec.hpc.temple.edu 'cd Puppet-HPC-virtual-cluster-automation/utils; rake deploydevelop; python triggerapplyall.py'; 
#ssh mtaifi@tec.hpc.temple.edu 'cd Puppet-HPC-virtual-cluster-automation/utils; rake deploy; rake apply CLIENT=10.80.160.13'; 
