namespace :osx do
  desc "Symlink the mysql.sock from MacPorts into /tmp"
  task :mysql_sock do
    sh "ln -s /opt/local/var/run/mysql5/mysqld.sock /tmp/mysql.sock"
  end
end