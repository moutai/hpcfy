
git add ../.
git commit -a; 

git push; 


ssh mtaifi@tec.hpc.temple.edu 'cd Puppet-HPC-virtual-cluster-automation/utils; rake deploy; python triggerapplyall.py'; 
