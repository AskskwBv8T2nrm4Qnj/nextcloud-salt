nextcloud_domain: "nextcloud.example.com"

{# Let's configure our local MariaDB service for NextCloud #}
mariadb_nextcloud_database: "nextcloud"
mariadb_nextcloud_user: "dbuser"
mariadb_nextcloud_user_password: "example_password_for_nextcloud_user123"

{# Let's connect to our local MariaDB service! #}
{# Official: https://docs.saltproject.io/en/3006/ref/modules/all/salt.modules.mysql.html #}
{# Find out where your Unix socket lives!!! - "mysqladmin variables | grep socket" #}
{# https://stackoverflow.com/questions/6885164/pymysql-cant-connect-to-mysql-on-localhost #}
mysql.host: 'localhost'
mysql.port: 3306
mysql.user: 'root'
mysql.pass: ''
mysql.db: 'mysql'
mysql.unix_socket: '/var/lib/mysql/mysql.sock'
mysql.charset: 'utf8'
