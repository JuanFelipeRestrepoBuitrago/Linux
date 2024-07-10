docker run -d --name mysql_instance -v mysql_instance_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123 -p 3306:3306 mysql:8.4.0
