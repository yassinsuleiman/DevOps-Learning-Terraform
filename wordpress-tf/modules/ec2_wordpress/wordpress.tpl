#cloud-config
package_update: true
packages:
  - apache2
  - libapache2-mod-php
  - php
  - php-mysql
  - php-curl
  - php-xml
  - php-mbstring
  - unzip
runcmd:
  - curl -L -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
  - tar -xzf /tmp/wordpress.tar.gz -C /tmp
  - rm -rf /var/www/html/*
  - cp -r /tmp/wordpress/* /var/www/html/
  - cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  - sed -i "s/database_name_here/${db_name}/" /var/www/html/wp-config.php
  - sed -i "s/username_here/${db_user}/" /var/www/html/wp-config.php
  - sed -i "s/password_here/${db_passwd}/" /var/www/html/wp-config.php
  - sed -i "s/localhost/${db_host}/" /var/www/html/wp-config.php
  # Make index.php the default
  - sed -i 's/DirectoryIndex .*/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf
  # Health check page
  - bash -lc 'echo OK > /var/www/html/health.html'
  - chown -R www-data:www-data /var/www/html
  - find /var/www/html -type d -exec chmod 755 {} \;
  - find /var/www/html -type f -exec chmod 644 {} \;
  - systemctl enable apache2
  - systemctl restart apache2