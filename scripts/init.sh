mysql_install_db --user=root --datadir=/var/lib/mysql/1/
mysql_install_db --user=root --datadir=/var/lib/mysql/2/
mysql_install_db --user=root --datadir=/var/lib/mysql/3/
mysql_install_db --user=root --datadir=/var/lib/mysql/4/

mysqld_multi start 1
mysqld_multi start 2
mysqld_multi start 3
mysqld_multi start 4

### These starts do not happen immediate. This sleep is a low tech way to wait. Needs to be replaced with a proper check that loops for all four databases are up
sleep 15

mysql -S /var/lib/mysql/1/mysql.sock -P 33061 < ./scripts/mariadb.sql 
mysql -S /var/lib/mysql/2/mysql.sock -P 33062 < ./scripts/mariadb.sql 
mysql -S /var/lib/mysql/3/mysql.sock -P 33063 < ./scripts/mariadb.sql 
mysql -S /var/lib/mysql/4/mysql.sock -P 33064 < ./scripts/mariadb.sql 

sleep 5
mysql -S /var/lib/mysql/1/mysql.sock -P 33061 < ./scripts/seed.sql

maxctrl call command mariadbmon reset-replication TheMonitor server1
