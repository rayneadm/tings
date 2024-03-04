# How to add iptables rules in autostart

### First one 
That ruls user **ens3** ifname, check your ifname before use it.  

## Second ..
These rules contain private and/or fake addresses,  
this also needs to be checked and corrected before use.  

### Last one :alien: 
This list lists the ipv4 and ipv6 rules for a DNS server such as BIND9.  
have been tested on a production server, more information about   
BIND9 or iptables is available in the links below.

```shell
sh ./ip4.rules.sh
sh ./ip6.rules.sh
iptables-save > /etc/iptables.up.v4.rules
ip6tables-save > /etc/iptables.up.v6.rules
```
To show rule result run:
`iptable -L -n -v`	
`ip6table -L -n -v`

To clear all rules use `iptable -F && ip6table -F`


```shell
touch /etc/network/if-pre-up.d/iptables
chmod +x /etc/network/if-pre-up.d/iptables
vi /etc/network/if-pre-up.d/iptables
```

Add bellow in */etc/network/if-pre-up.d/iptables*
```shell
#!/bin/sh
#
# Load iptables rules from this file
#
/sbin/iptables-restore < /etc/iptables.up.v4.rules
/sbin/ip6tables-restore < /etc/iptables.up.v6.rules
```		



# Links
* [BIND9 \ named](https://bind9.net/)
* [iptables \ netfilter](https://www.netfilter.org/projects/iptables/index.html)  


