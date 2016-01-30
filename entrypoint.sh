service mysql start
service apache2 start
tail -f /var/log/apache2/access.log /var/log/apache2/error.log
