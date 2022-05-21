iptables --flush
iptables --table nat --flush
iptables --delete-chain
#Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
#Allow established connections:
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE
iptables -A FORWARD -i ens160 -j ACCEPT
#open 80 443 port
iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT

#DNS
iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT 



#ssh port
iptables -I INPUT -s {Myip-in local pc not server}  -p tcp -m tcp --dport 22 -j ACCEPT



iptables -A INPUT -j DROP
