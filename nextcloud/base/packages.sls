base_packages:
{# Install basic required packages #}
    pkg.installed:
        - allow_updates: True
        - refresh: True
        - pkg_verify: True
        - pkgs:
            - epel-release
            - yum-utils
            - httpd
            - unzip
            - curl
            - wget
            - bash-completion
            - policycoreutils-python-utils
            - mlocate
            - bzip2
            - mariadb-server
            - zip
            - python3-pip

install_pymysql:
{# Hard requirement for connecting to the database! #}
{# https://docs.saltproject.io/en/3006/ref/modules/all/salt.modules.mysql.html #}
    pip.installed:
        - name: pymysql
    require:
        - pkg: python3-pip

php_packages:
{# Install PHP dependencies of NextCloud #}
    pkg.installed:
        - allow_updates: True
        - refresh: True
        - pkg_verify: True
        - pkgs:
            - php
            - php84-php
            - php84-php-gd
            - php84-php-mbstring
            - php84-php-process
            - php84-php-xml
            - php84-php-pecl-zip
            - php84-php-pdo
            - php84-php-mysqlnd
            - php84-php-intl
            - php84-php-bcmath
            - php84-php-gmp

enable_php_remi84:
{# We manually trigger this because enabling modules is difficult for Salt #}
    cmd.run:
        - name: dnf module enable php:remi-8.4 -y
