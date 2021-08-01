#!/bin/bash
#
#	script that shows some information of the system
#
# Path compatibility for cron
PATH=$PATH:/usr/sbin
#
#	Architecture info
#
echo
echo "	#Architecture:"
echo "	 $(uname -srv)"
echo "	#OS: $(uname -om)"
#
#	"physical processor" means all the physical processing unit present in the system:
#	The formula is: Socket(s) X Core(s) per socket
#
Socket="$(lscpu | sed -n 's/^Socket(s)://p')"
Core="$(lscpu | sed -n 's/Core(s) per socket://p')"
echo "	#CPU physical:	$(($Socket * $Core))"
#
#	"virtual processors" means all the processing units recognised by the system:
#	The formula is: Socket(s) X Core(s) per socket X Thread(s) per core
#
vcpu="$(lscpu | sed -n 's/^CPU(s):[[:space:]]\+//p')"
echo "	#vCPU:		$vcpu"
#
#	Memory Usage
#
used_m="$(free --mega | awk 'NR==2 {print $3}')"
ava_m="$(free --mega | awk 'NR==2 {print $7}')"
tot_m="$(free --mega | awk 'NR==2 {print $2}')"
echo -n "	#Memory Usage: $used_m MB"
free --mega | awk 'NR==2 {printf(" (%.2f%%) "), $3/$2*100}'
echo "| available: $ava_m MB"
#
#	CPU Load
#
time_c="$(top -bn1 | awk 'NR>7 {SUM+=$9}END{print SUM}')"
tot_p=$((vcpu * 100))
awk -v t_c=$time_c -v t_p=$tot_p 'BEGIN{print "	#CPU load: "(t_c/t_p)*100"%"}'
#
#	System last boot
#
time_lb="$(who -b | sed -n 's/[[:space:]]\+system boot[[:space:]]\+//p')"
echo "	#Last boot: $time_lb"
#
#	Using LVM
#
lsblk | awk -v str="no" '{if ($6 == "lvm") str="yes"}END{print "	#LVM use: "str}'
#
#	Number of active connections
#	"ss -atunp" shows all services that use tcp or udp
#	"ss -t" instead shows not listening connections using tcp
#
ss -t | awk -v c=0 'NR>1 {if ($1 == "ESTAB") c++ } END{print "	#Connections TCP : "c" ESTABLISHED"}'
#
#	Users logged to the server
#
echo "	#User log: "$(who | wc -l)
#
#	IPv4 and MAC addresses of the server
#
echo "	#Network:	*IPv4* "$(hostname -I)
echo "			*MAC* "$(ip -0 a | awk '/link\/ether/ {print $2}')
#
#	Numbers of commands executed with sudo
#
echo "	#Sudo: "$(journalctl _COMM=sudo | grep COMMAND | wc -l)
