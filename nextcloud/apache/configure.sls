httpd_restart:
{# Reload and enable the httpd service #}
  service.running:
    - name: httpd
    - enable: True
    - reload: True

http_firewalld_access:
{# HTTP access through firewalld #}
  firewalld.present:
    - name: public
    - ports:
      - 80/tcp
      - 80/udp

httpd_create_sites-available:
{# Create a basic structure for HTTPD #}
  file.directory:
    - name: /etc/httpd/sites-available
    - makedirs: True

httpd_create_sites-enabled:
{# Create a basic structure for HTTPD #}
  file.directory:
    - name: /etc/httpd/sites-enabled

{% if not salt['file.file_exists'] ('/etc/httpd/sites-enabled/' + pillar["nextcloud_domain"]) %}
{# We create a proper webdomain file, but only if it does't exist yet #}
httpd_copy_webconfig:
  file.managed:
    - name: /etc/httpd/sites-available/{{ pillar['nextcloud_domain'] }}
    - source:
      - salt://apache/virtualhost.html

httpd_replace_domain:
{# We replace some of the contents of our copied virtualhosts file #}
  file.replace:
    - name: /etc/httpd/sites-available/{{ pillar['nextcloud_domain'] }}
    - pattern: '\[This_is_a_placeholder_for_sedding_the_domain]'
    - repl: {{ pillar['nextcloud_domain'] }}
    - show_changes: True

{# https://stackoverflow.com/questions/22673022/check-file-exists-and-create-a-symlink/30454953#30454953  #}
httpd_symlink_virtualhost:
  file.symlink:
    - name: /etc/httpd/sites-enabled/{{ pillar['nextcloud_domain'] }}
    - target: /etc/httpd/sites-available/{{ pillar['nextcloud_domain'] }}
{% endif %}

httpd_configure_sites-enabled_folder:
{# We add the sites-enabled folder, so it will be watched by HTTPD for website #}
  file.append:
    - name: /etc/httpd/conf/httpd.conf
    - text:
      - Include /etc/httpd/sites-enabled

httpd_create_webroot:
{# We create the place, where we will be uploading the files for NextCloud #}
  file.directory:
    - name: /var/www/sub-domains/{{ pillar['nextcloud_domain'] }}
    - makedirs: True

{#
httpd_php_add_timezone:
  file.append:
    - name: /etc/opt/remi/php84/php.ini
    - text:
      - date.timezone = "Europe/Amsterdam"
 #}
