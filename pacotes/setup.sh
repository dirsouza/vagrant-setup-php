#!/bin/bash

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Definindo Senha padrao para o MySQL e suas ferramentas ---"

DEFAULTPASS="root"

sudo apt-get update
sudo debconf-set-selections <<EOF
	mysql-server		mysql-server/root_password password $DEFAULTPASS
	mysql-server		mysql-server/root_password_again password $DEFAULTPASS
	dbconfig-common		dbconfig-common/mysql/app-pass password $DEFAULTPASS
	dbconfig-common		dbconfig-common/mysql/admin-pass password $DEFAULTPASS
	dbconfig-common		dbconfig-common/password-confirm password $DEFAULTPASS
	dbconfig-common		dbconfig-common/app-password-confirm password $DEFAULTPASS
	phpmyadmin		    phpmyadmin/reconfigure-webserver multiselect apache2
	phpmyadmin		    phpmyadmin/dbconfig-install boolean true
	phpmyadmin      	phpmyadmin/app-password-confirm password $DEFAULTPASS 
	phpmyadmin      	phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
	phpmyadmin      	phpmyadmin/password-confirm     password $DEFAULTPASS
	phpmyadmin     		phpmyadmin/setup-password       password $DEFAULTPASS
	phpmyadmin      	phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF

echo "--- Instalando MySQL e alguns outros modulos ---"
sudo apt-get install -y mysql-server-5.7 mysql-client phpmyadmin

sudo /usr/bin/mysqladmin -u root password 'root'

sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"

mysql -u root -proot -e "DROP USER ''@'localhost';"
mysql -u root -proot -e "DROP USER ''@'$(hostname)';"
mysql -u root -proot -e "DROP DATABASE test;"

mysql -u root -proot -e "FLUSH PRIVILEGES;"

sudo /etc/init.d/mysql restart

echo "--- Instalando PHP, Apache e alguns modulos ---"
sudo apt-get install -y php7.2 php7.2-bcmath php7.2-bz2 php7.2-cgi php7.2-cli php7.2-cli php7.2-common php7.2-curl php7.2-dev php7.2-fpm php7.2-dg php7.2-interbase php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap php7.2-sqlite3 php7.2-xml php7.2-zip
sudo apt-get install -y libapache2-mod-php7.2 zip unzip

echo "--- Habilitando o PHP 7.2 ---"
sudo a2enmod php7.2

echo "--- Habilitando mod-rewrite do Apache ---"
sudo a2enmod rewrite

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

echo "--- Baixando e Instalando Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Instalando Banco NoSQL -> Redis <- ---" 
sudo apt-get install -y redis-server
sudo apt-get install -y php-redis

# Instale apartir daqui o que você desejar 
sudo apt-get install -y nodejs
sudo apt-get install -y npm
sudo npm install -g vue-cli

echo "--- Altomatizar Virtualhosts ---"
git clone https://github.com/RoverWire/virtualhost.git /home/vagrant/virtualhost
cd /home/vagrant/virtualhost/
sudo chmod +x virtualhost.sh
sudo cp /home/vagrant/virtualhost/virtualhost.sh /usr/local/bin/virtualhost
sudo chmod +x /usr/local/bin/virtualhost
cd /usr/local/bin
sudo wget -O virtualhost https://raw.githubusercontent.com/RoverWire/virtualhost/master/virtualhost.sh
sudo chmod +x virtualhost
sudo wget -O virtualhost-nginx https://raw.githubusercontent.com/RoverWire/virtualhost/master/virtualhost-nginx.sh
sudo chmod +x virtualhost-nginx
cd
sudo cp /home/vagrant/virtualhost/locale/pt_BR/virtualhost.mo /usr/share/locale/pt_BR/LC_MESSAGES/
sudo cp /home/vagrant/virtualhost/locale/pt_BR/virtualhost-nginx.mo /usr/share/locale/pt_BR/LC_MESSAGES/
#sudo rm -rf /home/vagrant/virtualhost #Remove a pasta

echo "--- Vincular pasta /var/www/html a pasta code em /home/vagrant/code"
sudo ln -s /var/www/html /home/vagrant/code
sudo chmod +x /home/vagrant/code

echo "[OK] --- Ambiente de desenvolvimento concluido ---"
