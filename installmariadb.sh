
#!/bin/bash

yum install mariadb-server mysql-utilities -y

systemctl enable mariadb.service
systemctl start mariadb.service

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('rusty69Joane') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

cat > /etc/my.cnf.d/server.cnf << EOF
# this is read by the standalone daemon and embedded servers
[server]
# this is only for the mysqld standalone daemon
[mysqld]
bind-address=0.0.0.0
port=3306
#plugin-load=auth_pam.so
# this is only for embedded server
[embedded]
# This group is only read by MariaDB-5.5 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand
[mysqld-5.5]
# These two groups are only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here
[mariadb]
[mariadb-5.5]
EOF

#firewall-cmd --zone=public --add-service=mysql --permanent
#iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 3306 -j ACCEPT

systemctl restart mariadb.service

#CREATE USER 'dbuser'@'%' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON database.* TO 'dbuser'@'%';
#flush privileges;
