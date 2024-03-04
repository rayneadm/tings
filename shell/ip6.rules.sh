#/usb/bin/bash
# Clean all existing rules 
ip6tables -F

# Allow  local host ipv6 connections
ip6tables -A INPUT   -i lo     -j ACCEPT

# Allow outcomming connections 
ip6tables -P OUTPUT ACCEPT

# Allow established connections
ip6tables -A INPUT   -m state --state ESTABLISHED,RELATED -j ACCEPT
ip6tables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow DNS Server connections
ip6tables -A INPUT -p udp --dport 53 -j ACCEPT
ip6tables -A OUTPUT -p udp --sport 53 --dport 1024:65535 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 53 -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 53 --dport 1024:65535 -j ACCEPT

# Allow SSH connections freom ipv6 address
ip6tables -A INPUT -p tcp -s fe00:0000:1111:ffff::/64 --dport 22 -j ACCEPT

# Allow ICMP
ip6tables -A INPUT             -p icmpv6 -m limit --limit 900/min -j ACCEPT
ip6tables -A FORWARD -o ens3 -p icmpv6 -m limit --limit 900/min -j ACCEPT

# Port-scan guard
ip6tables -N port-scanning
ip6tables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
ip6tables -A port-scanning -j DROP

# Block invalid packets
ip6tables -A INPUT -i ens3 -m conntrack --ctstate INVALID -j DROP

# Block new packets without SYN
ip6tables -A INPUT -i ens3 -p tcp ! --syn -m conntrack --ctstate NEW -j DROP

# Block new packets with fragments
ip6tables -A INPUT -i ens3 -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP

# Block fragmented packets ipv6
ip6tables -A INPUT -m frag --fragmore -j DROP

#  Block wrong TCP flags
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags FIN,ACK FIN -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ACK,URG URG -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ACK,FIN FIN -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ACK,PSH PSH -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ALL ALL -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ALL NONE -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
ip6tables -A INPUT -i ens3 -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

# Default policy end of rules
ip6tables -A INPUT -j REJECT --reject-with icmp6-adm-prohibited
ip6tables -A FORWARD -j REJECT --reject-with icmp6-adm-prohibited
