mariadb_restart:
{# Reload and enable the mariadb service #}
    service.running:
        - name: mariadb
        - enable: True
        - reload: True

nextcloud_db:
{# Create the nextcloud database #}
    mysql_database.present:
        - name: {{ pillar['mariadb_nextcloud_database'] }}
    require:
        - pip: pymysql
        - name: mariadb_root_password

nextcloud_db_user:
{# create a NextCloud user for the new database with the username/password coming from the pillar file #}
    mysql_user.present:
        - name: {{ pillar['mariadb_nextcloud_user'] }}
        - password: {{ pillar['mariadb_nextcloud_user_password'] }}
    require:
        - name: nextcloud_db

nextcloud_db_user_grant:
{# Grant permission to our newly NextCloud created user #}
    mysql_grants.present:
        - grant: all privileges
        - database: {{ pillar['mariadb_nextcloud_database'] }}.*
        - user: {{ pillar['mariadb_nextcloud_user'] }}
    require:
        - name: nextcloud_db_user
