# iptables DDNS

i wana use iptables but not have ip static 

i try creat script and use ddns for get my ip 

1. add ddns to my router use no-ip

```bash
mkdir ~/script
cd ~/script
git clone https://github.com/Rezasalami/iptablesdefult.git
```

In crontab I call this script every 5 minutes :
add this line 

```bash
*/5 * * * * /bin/bash ~/script/iptablesdefult/myiptables.sh
```

Done!!!!
