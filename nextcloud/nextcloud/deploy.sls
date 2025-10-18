{% if not salt['file.directory_exists'] ('/var/www/sub-domains/' + pillar["nextcloud_domain"] + '/html') %}
nextcloud_download:
{# We download the latest nextcloud files #}
    file.managed:
        - skip_verify: true
        - name: /root/nextcloud_latest.zip
        - source:
            - https://download.nextcloud.com/server/releases/latest.zip

nextcloud_extract:
{# We extract the latest nextcloud to our subdomain folder #}
    archive.extracted:
        - name: /var/www/sub-domains/{{ pillar["nextcloud_domain"] }}/
        - source: file:///root/nextcloud_latest.zip
        - user: apache
        - group: apache
    require:
        - name: nextcloud_download

nextcloud_rename_folder:
{# We move the folder to /html rather than its original name of 'nextcloud' #}
    cmd.run:
        - name: mv /var/www/sub-domains/{{ pillar["nextcloud_domain"] }}/nextcloud /var/www/sub-domains/{{ pillar["nextcloud_domain"] }}/html
    require:
        - name: nextcloud_extract


nextcloud_delete_zip:
{# Finally, we delete the zip #}
    file.absent:
        - name: /root/nextcloud_latest.zip
    require:
        - name: nextcloud_extract
{% endif %}

nextcloud_httpd_restart:
{# We restart httpd manually because Salt is bad at forcing restarts #}
    cmd.run:
        - name: systemctl restart httpd
