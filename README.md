# MediaWiki
<b>MediaWiki</b> adalah sebuah paket perangkat lunak open source gratis wiki yang ditulis dalam PHP, awalnya untuk digunakan di Wikipedia. Hal ini sekarang digunakan oleh beberapa proyek lain non-profit Wikimedia Foundation dan oleh wiki lain.

# SAYA MEMPUNYAI 2 PILIHAN PROSES INSTALLASI

<b><h2> 1. Installasi dengan shell script (.sh) installasi jadi lebih mudah dan auto selesai dengan sendirinya. </b></h2>

<b>Disarankan masuk sebagai superuser (root) terlebih dahulu, agar mempermudah ketika proses penginstalan.

Dengan perintah: </b>
```
sudo su
```
atau
```
su
```
install git terlebih dahulu (jika belum install):
```
apt install git
```
Download atau clone repo gitnya terlebih dahulu:
```
git clone https://github.com/arifzxc/mediawiki
```
masuk ke dalam directory terlebih dahulu:
```
cd mediawiki/
```
Menjalankan shell script untuk linux ubuntu (database mysql):
```
sh ubuntu.sh
```
Menjalankan shell script untuk linux debian (database mariadb):
```
sh debian.sh
```

<b>Selesai, tinggal mengatur database dan config diwebnya bisa scroll ke bawah.</b>



<b><h2> 2. Dengan command line copy paste manual, silahkan ikuti perintah dibawah ini. </b></h2>


<b>Disarankan masuk sebagai superuser (root) terlebih dahulu, agar mempermudah ketika proses penginstalan.<br>

Dengan perintah: </b>
```
sudo su
```
atau
```
su
```

<b> Download extension yang dibutuhkan (minimal menggunakan php versi 7.2 keatas) </b>

Linux Ubuntu, biasanya menggunakan mysql:
```
sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl \
mysql-client mysql-server libphp-adodb libgd-dev php-pear \
php-common libapache2-mod-php php-fpm \
php-bz2 php-xml imagemagick php-zip php-mbstring -y
```

Linux Debian, biasanya menggunakan mariadb:
```
sudo apt install apache2 php php-xmlrpc php-mysql php-gd php-cli php-curl \
mariadb-client mariadb-server libphp-adodb libgd-dev php-pear \
php-common libapache2-mod-php php-fpm \
php-bz2 php-xml imagemagick php-zip php-mbstring -y
```
Set locale
```
locale-gen id_ID.UTF-8
```

# MENGATUR DATABASE

Setup root password<br>
copy perintah dibawah ini dan paste dinotepade dahulu, edit kata yang ada didalam kurung ini <b>('password')</b> dengan password yang ingin kalian bikin, kemudian copy semua perintah yang tadi sudah diubah passwordnya, dan paste diterminal linux.
```
mysql
```
```
SET PASSWORD FOR root@localhost=PASSWORD('password');
exit
```
Masuk mysql dengan perintah dibawah ini, kemudian masukan password yang barusan dibuat diatas:
```
mysql -u root -p
```

Bikin databasenya, masukan seperti dibawah ini (untuk password bisa diubah sesuai keinginan):
```
create database mediawiki;
grant INSERT,SELECT on root.* to mediawiki@localhost;
grant CREATE, INSERT, SELECT, DELETE, UPDATE, DROP, INDEX on mediawiki.* to mediawiki@localhost identified by 'mediawikipass';
grant CREATE, INSERT, SELECT, DELETE, UPDATE, DROP, INDEX on mediawiki.* to mediawiki identified by 'mediawikipass';
exit
```

Download & mengatur permission file.
```
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
```
Restart linux ubuntu (mysql):
```
/etc/init.d/mysql restart
```
Restart linux debian (mariadb):
```
/etc/init.d/mariadb restart
```

# MENGUBAH KECEPATAN UPLOAD, DLL. UNTUK WEB SERVER APACHE2 AGAR LEBIH STABIL
Silahkan sesuaikan dengan versi php yang sudah diinstall<br>
untuk cek versi php, bisa menggunakan perintah:
```
php -v
php --version
````
edit menggunakan perintah:<br>
sesuaikan dengan versi php yang dipakai.
```
sudo vi /etc/php/7.2/apache2/php.ini
sudo vi /etc/php/7.3/apache2/php.ini
sudo vi /etc/php/7.4/apache2/php.ini
```
atau
```
sudo nano /etc/php/7.2/apache2/php.ini
sudo nano /etc/php/7.3/apache2/php.ini
sudo nano /etc/php/7.4/apache2/php.ini
```

cari text dan ubah sesuai dengan contoh dibawah ini:
```
upload_max_filesize = 100M
post_max_size = 48M
memory_limit = 512M
max_execution_time = 600
max_input_vars = 3000
max_input_time = 1000
```

restart apache2:
```
/etc/init.d/apache2 restart
```
atau
```
systemctl restart apache2.service
```

# MENGAKSES & PROSES CONFIG MEDIAWIKI

Bisa diakses menggunakan ip address yang didapat oleh device yang digunakan untuk install mediawiki.

Cek ip address menggunakan:
```
ifconfig
```
atau di linux debian menggunakan salah satu dibawah ini:
```
/sbin/ifconfig
/usr/sbin/ifconfig
```

Contoh hasil ifconfig:
```
eth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether de:31:23:0d:b1:e3  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 22  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 19  bytes 1644 (1.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 19  bytes 1644 (1.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.73  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::e735:89f:f9c2:87d9  prefixlen 64  scopeid 0x20<link>
        ether 04:95:73:ba:4c:9b  txqueuelen 1000  (Ethernet)
        RX packets 37452  bytes 359654791 (342.9 MiB)
        RX errors 0  dropped 174  overruns 0  frame 0
        TX packets 15731  bytes 8735213 (8.3 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

Berhubung saya menggunakan akses jaringan menggunakan Wifi, bisa dilihat di <b>wlan0</b><br>
Ip address yang didapat oleh device adalah: <b>192.168.1.73</b> maka untuk mengaksesnya dengan cara membuka browser dan mengetikan ip yang didapat, contoh dibawah ini:
```
http://192.168.1.73/wiki
```
atau menggunakan localhost
```
http://localhost/wiki
```

<b>SETUP WIKI</b><br>
Bebas mau menggunakan bahasa apa, rekomend Bahasa Inggris supaya pintar Bahasa Inggris, dan gajinya dolar hehe..
```
Your language: en - English
Wiki language: en - English -> continue
Environmental checks -> continue
(Yang penting ada tulisan <b>The environment has been checked. You can install MediaWiki.</b> warna hijau.)

Connect to database:<br>
(Jika membuat database sendiri, bisa disesuaikan sendiri datanya.)

  Database type: MariaDB, MySQL, or compatible
  Database host: localhost
  Database name: mediawiki
  Database table prefix: wiki_
  Database username: mediawiki
  Database password: mediawikipass -> continue

Database settings:

  Use the same account as for installation (checklist)
  Storage engine: InnoDB -> continue

Name:

  Name of wiki:
  Project namespace: (Same as the wiki name:)

Administrator account:

  Your username:
  Password:
  Password again:
  Email address:
  Subscribe to the release announcements mailing list (unchecklist)
  Share data about this installation with MediaWiki developers. (unchecklist)
  I'm bored already, just install the wiki. (checklist) -> continue

Install -> continue

Install (all done) -> continue

Download file LocalSettings.php (biasanya langsung ke download otomatis)
```

Copy file LocalSettings.php ke /var/www/html/wiki (untuk sesama linux)
```
scp Downloads/LocalSettings.php  root@input_ip_server:/var/www/html/wiki
```
cara bacanya
```
securecopy file LocalSettings.php ngambil dari folder Download/ dikirim ke ip server linux yang sudah diinstall mediawiki, tujuan ke folder /var/www/html/wiki
```

Alternatif untuk copy file bisa menggunakan software file sharing, bisa menggunakan:
```
FileZilla: https://filezilla-project.org/download.php

Cara penggunaan: masukan ip server (sftp://ip_server), masukan user, masukan password, masukan port 22
```

Menambah script DB di file LocalSettings.php
```
vi /var/www/html/wiki/LocalSettings.php
```
atau
```
nano /var/www/html/wiki/LocalSettings.php
```

Masukan, dibaris paling bawah.<br>
(Jika membuat database sendiri, bisa disesuaikan sendiri datanya.)
```
$wgDBadminuser      = mediawiki;
$wgDBadminpassword  = mediawikipass;
?>
```

Refresh website mediawikinya, atau bisa diakses ulang:
```
http://localhost/wiki
http://ip_server/wiki (masukan sesuai ip server yang digunakan untuk install mediawiki)
```

<br>
<b>Selesai, semoga bermanfaat tutorial installasi MediaWiki yang sudah saya bikin.<br>
Mohon maaf jika ada kata-kata yang kurang nyambung atau lainnya.<br>
Terima Kasih...</b>
