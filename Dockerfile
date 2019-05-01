FROM ubuntu:latest

WORKDIR /

RUN apt-get update && \
    apt-get install -y python-mysqldb mysql-server && \
    service mysql start && \
    mysql -e "CREATE DATABASE bbdd" && \
    mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password'" && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION" && \
    sed -i 's/bind-address/#bind-address/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service mysql stop && \
    chown -R mysql:mysql /var/run/mysqld

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD ["mysqld_safe"]