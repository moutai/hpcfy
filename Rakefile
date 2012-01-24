PUPPETMASTER = '10.80.160.13'
USER = 'root'
SSH= 'ssh'

task :deploy do
sh "git push"
sh "#{SSH} #{USER}@#{PUPPETMASTER} cd /etc/puppet; git pull origin master"
end


task :apply => [:deploy] do
client = ENV['CLIENT']
sh "#{SSH} #{USER}@#{client} 'puppet agent --test'" do |ok, status|
puts case status.exitstatus
when 0 then "Client is up to date."
when 1 then "Puppet couldn't compile the manifest."
when 2 then "Puppet made changes."
when 4 then "Puppet found errors."
end
end
end



