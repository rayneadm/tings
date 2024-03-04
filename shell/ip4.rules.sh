#/usb/bin/bash
# Clean all existing rules 
iptables -F

# Allow  local host ipv4 connections
iptables -A INPUT   -i lo     -j ACCEPT

# Allow outcomming connections 
iptables -P OUTPUT ACCEPT

# Allow established connections
iptables -A INPUT   -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow DNS Server connections
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --sport 53 --dport 1024:65535 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 53 --dport 1024:65535 -j ACCEPT

# Allow SSH connections
iptables -A INPUT -p tcp -s 192.168.1.0/24  --dport 22 -j ACCEPT

# Allow  ICMP
iptables -A INPUT             -p icmp -m limit --limit 900/min -j ACCEPT
iptables -A FORWARD -o ens3 -p icmp -m limit --limit 900/min -j ACCEPT

# Port-scan guard
iptables -N port-scanning
iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
iptables -A port-scanning -j DROP

# Block invalid packets
iptables -A INPUT -i ens3 -m conntrack --ctstate INVALID -j DROP

# Block new packets without SYN
iptables -A INPUT -i ens3 -p tcp ! --syn -m conntrack --ctstate NEW -j DROP

# Block new packets with fragments
iptables -A INPUT -i ens3 -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP

# Block fragmented packets ipv4
iptables -A INPUT -i ens3 -f -j DROP

#  Block wrong TCP flags
iptables -A INPUT -i ens3 -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags FIN,ACK FIN -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ACK,URG URG -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ACK,FIN FIN -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ACK,PSH PSH -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

# Default policy end of rules
iptables -A INPUT -j REJECT --reject-with icmp-admin-prohibited
iptables -A FORWARD -j REJECT --reject-with icmp-admin-prohibited
