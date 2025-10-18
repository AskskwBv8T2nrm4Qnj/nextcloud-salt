{#
When you manually install PHP, you also require these repositories
We add repositories that have "enabled=1" set during manual installation of the remi .rpm
But also the "remi" repo itself, which comes as disabled by default
#}

remi_gpg-key_9:
    file.managed:
        - skip_verify: true
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el9
        - source:
            - https://rpms.remirepo.net/enterprise/9/RPM-GPG-KEY-remi

remi_gpg-key_10:
    file.managed:
        - skip_verify: true
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el10
        - source:
            - https://rpms.remirepo.net/enterprise/10/RPM-GPG-KEY-remi

remi:
    pkgrepo.managed:
        - humanname: Remi's RPM repository for Enterprise Linux $releasever - $basearch
        - mirrorlist: http://cdn.remirepo.net/enterprise/$releasever/remi/$basearch/mirror
        - gpgcheck: 1
        - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el$releasever
        - enabled: false

remi-modular:
    pkgrepo.managed:
        - humanname: Remi's Modular repository for Enterprise Linux $releasever - $basearch
        - mirrorlist: http://cdn.remirepo.net/enterprise/$releasever/modular/$basearch/mirror
        - gpgcheck: 1
        - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el$releasever

remi-safe:
    pkgrepo.managed:
        - humanname: Safe Remi's RPM repository for Enterprise Linux $releasever - $basearch
        - mirrorlist: http://cdn.remirepo.net/enterprise/$releasever/safe/$basearch/mirror
        - gpgcheck: 1
        - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi.el$releasever
