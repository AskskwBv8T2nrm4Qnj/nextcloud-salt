# NextCloud Salt
This repository is the result of a weekly school assignment.
The objective was simple: deploy NextCloud using SaltStack.
I went a bit overboard on the usage of Salt and its conventions.

You should modify the pillar file within `nextcloud_pillar/` to your liking.
The end-result is NextCloud being available on port 80 for the domain you configured within the pillar file.
This project assumes you have firewalld already installed.

This repository serves mostly as personal reference and documentation.
Maybe in 10 years I'll be using Salt in some company, who knows?
If it's useful to anyone in the meantime, I will be happy.
Usually I document most of my nonsense on https://wiki.brammerloo.nl/.
But I decided against it for SaltStack, it doesn't lend well to MediaWiki formatting...

It also  bothered me how few 'practical' Salt projects there are on the internet.
I mean, the documentation for all the little parameters is great and all...
But sharing only the ingredients from a recipe, does not a great meal make, no?

It works on my Rocky Linux 9.6 VMs.
With some minor refactoring, you could also use it for other distributions.
Usage is at your own risk though, I take no responsibility for anything you mess up ;)

Check out [this example output](example_output.txt) if you want an indication of what a state apply does.

# Installation
No idea how exactly you would make this repository part of a working or new environment.

But probably something like the following, if you were to clone it to /srv/salt/
Do note that there are already top.sls files for both the nextcloud and nextcloud_pillar folders!
If you already have top.sls files, you may have to add the new file-paths within them...?

```
cd /srv/salt
git clone https://github.com/AskskwBv8T2nrm4Qnj/nextcloud-salt.git
```

Modify the /etc/salt/master file to point to the nextcloud and nextcloud_pillar folders:
```
file_roots:
  base:
    - /srv/salt/
  nextcloud:
    - /srv/salt/nextcloud-salt/nextcloud/

pillar_roots:
  base:
    - /srv/pillar
  nextcloud_pillar:
    - /srv/salt/nextcloud-salt/nextcloud_pillar
```

Modify the pillar file to your liking:
```
nano /root/nextcloud-salt/nextcloud_pillar/nextcloud.sls
```

Do a refresh of your pillar data:
```
salt '*' saltutil.refresh_pillar
```

Run the .sls files for a host:
```
salt client.example.com state.apply install_nextcloud
```

# Sources
There are links scattered within the .sls files.

I based this Salt installation on the manual steps listed within the following links:
* https://docs.nextcloud.com/server/latest/admin_manual/installation/example_centos.html
* https://docs.rockylinux.org/10/guides/cms/cloud_server_using_nextcloud/

A few other references I used:
* https://docs.saltproject.io/en/latest/ref/states/all/salt.states.pkgrepo.html
* https://docs.saltproject.io/en/latest/ref/states/all/salt.states.file.html
* https://docs.saltproject.io/en/3006/ref/states/all/salt.states.firewalld.html
* https://docs.saltproject.io/en/latest/ref/states/all/salt.states.archive.html
* https://serverfault.com/questions/909139/saltstack-stop-on-first-error
* https://stackoverflow.com/questions/22673022/check-file-exists-and-create-a-symlink/30454953#30454953

