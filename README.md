# Born2beroot
Project for 42_Roma

This project aims to introduce you to the wonderful world of virtualization.

You will create your first machine in VirtualBox (or UTM if you can’t use VirtualBox) under specific instructions. Then, at the end of this project, you will be able to set up your own operating system while implementing strict rules.

See the subjects for further information:

[NEW SUBJECT](Resources/Born2beroot_en_subject_3_2.pdf)

[OLD SUBJECT](Resources/Born2beroot_en.subject_OLD.pdf)

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

- Check status of chronyd (NTP client/server):
https://docs.fedoraproject.org/en-US/Fedora/18/html/System_Administrators_Guide/sect-Checking_if_chrony_is_synchronized.html

Usefull tips, commands:

- Passwords policy modified in:
```
/etc/login.defs
/etc/pam.d/common-password
/etc/security/pwquality.conf
```
- Sudo configuration file:
```
/etc/sudoers
/etc/sudoers.d/sudo_config
```

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

The systemctl command interacts with the SystemD service manager to manage the services. Contrary to service command, it manages the services by interacting with the SystemD process instead of running the init script.

```
systemctl --type='service_name' --state=active
systemctl -a
systemctl status 'service_name'
systemctl [ start | stop ] 'service_name'
systemctl [ enable | disable ] 'service_name'
systemctl mask 'service_name'
```
```
service 'service_name' status
```
Visualize log
```
journalctl
```

- UFW
```
ufw status numbered [verbose]
ufw delete 'number'
ufw allow 'port'
```
- CRON
```
crontab -l
crontab -e
```

- CRON EXAMPLE WITH THE [OLD MONITORING.SH](monitoring_OLD.sh) :

run at boot and every 10 minutes
```
@reboot bash monitoring.sh > monitoring.txt && wall -n monitoring.txt
*/10 * * * * bash monitoring.sh > monitoring.txt && wall -n monitoring.txt
```

run at boot and every 30 seconds
```
@reboot bash monitoring.sh > monitoring.txt && wall -n monitoring.txt
*/1 * * * * bash monitoring.sh > monitoring.txt && wall -n monitoring.txt
*/1 * * * * sleep 30 && bash monitoring.sh > monitoring.txt && wall -n monitoring.txt
```

- Change hostname, modify:
```
/etc/hostname
```

- BASIC
```
useradd [name]
adduser [name] [group]
groupadd [name]
addgroup [name]
groups
getent group [name]
passwd
chage -l <username>
usermod -a -G 'group_name' 'user_name'
hostname
ssh [-p [port] [-l 'login_name'] 'hostname'
lsblk
shutdown - [ h | r ] now
```
