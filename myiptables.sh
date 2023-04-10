#!/bin/bash
# Update ipset to let my dynamic IP in
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
if iptables -nL | grep myDDNS; then
        echo '---'
        echo 'remove myDDNS'
        iptables -F myDDNS;
        echo 'add new ip  from ddns'
        iptables -I myDDNS -p tcp -s $(dig +short my.ddns.com) -m state --state NEW -m tcp -j ACCEPT;
        echo 'finish'
        echo '---'
else
        echo '---'
        echo 'remove all iptablse config'
        iptables --flush;
        iptables --table nat --flush;
        iptables --delete-chain;
        echo 'add myDDNS chain'
        iptables -N myDDNS 2>/dev/null;
        iptables -I INPUT -j myDDNS;
        echo 'remove myDDNS data'
        iptables -F myDDNS;
        echo 'add access to localhost'
        iptables -A INPUT -i lo -j ACCEPT;
        iptables -A OUTPUT -o lo -j ACCEPT;
        echo 'add estavlished'
        iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT;
        iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT;
        iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE;
        iptables -A FORWARD -i ens160 -j ACCEPT;
        echo 'add access port 80 433 53--dns'
        iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT;
        iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT;
        iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT;
        echo 'add vpn port'
        iptables -I INPUT -s myip  -p tcp -m tcp --dport 22 -j ACCEPT
        echo 'add new ip  from ddns'
        iptables -I myDDNS -p tcp -s $(dig +short my.ddns.com) -m state --state NEW -m tcp -j ACCEPT;
        echo 'drop all ip'
        iptables -A INPUT -j DROP
        echo 'finish'
        echo '---'
fi
