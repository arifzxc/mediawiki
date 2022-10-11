# Masuk sebagai superuser (root) terlebih dahulu, agar mempermudah proses installasi. 

sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl \
mariadb-client mariadb-server libphp-adodb libgd-dev php-pear \
php-common libapache2-mod-php php-fpm \
php-bz2 php-xml imagemagick php-zip php-mbstring -y

locale-gen id_ID.UTF-8

cd /usr/local/src
wget https://releases.wikimedia.org/mediawiki/1.32/mediawiki-1.32.0.tar.gz
cp mediawiki-1.32.0.tar.gz /var/www/html/
cd /var/www/html/
tar zxvf mediawiki-1.32.0.tar.gz
mv mediawiki-1.32.0 wiki
cp -Rf /var/www/html/wiki/mw-config/ /var/www/html/wiki/config
chmod a+w /var/www/html/wiki/mw-config
chmod a+w /var/www/html/wiki/config
chmod -Rf 776 wiki
chown -Rf www-data.www-data wiki

/etc/init.d/mariadb restart

