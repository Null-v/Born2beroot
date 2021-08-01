# Born2beroot
Project for 42_Roma

This project aims to introduce you to the wonderful world of virtualization.

You will create your first machine in VirtualBox (or UTM if you can’t use VirtualBox) under specific instructions. Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

See the subjects for further information

[SUBJECTS](Resources/en.subject.pdf)

Usefull links:

- How To DNF:
https://docs.fedoraproject.org/en-US/quick-docs/dnf/

- Hardening sudoers configuration:
https://www.tecmint.com/sudoers-configurations-for-setting-sudo-in-linux/

- Configuration of UFW:
https://wiki.ubuntu-it.org/Sicurezza/Ufw

- Password policy:
https://www.server-world.info/en/note?os=CentOS_8&p=pam&f=1

- Installing & configuring lighttpd, Mariadb, PHP:
https://www.howtoforge.com/how-to-install-lighttpd-with-php-fpm-and-mariadb-on-centos-8/

Usefull tips, commands:

- SELINUX
```
sestatus
setenforce [ 0 | 1 ]
semanage port -l
```
Add port 4242 to be opened by ssh
```
semanage port -a -t ssh_port_t -p tcp 4242
```
httpd and related services can connect to network
(needed for lighttpd with PHP)
```
setsebool -P httpd_can_network_connect on
```

- SYSTEMD
```
systemctl --type='service_name' --state=active
systemctl -a
systemctl status 'service_name'
systemctl [ start | stop ] 'service_name'
systemctl [ enable | disable ] 'service_name'
systemctl mask 'service_name'
```
Visualize log
```
journalctl
```
