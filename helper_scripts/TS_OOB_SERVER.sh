#!/bin/bash

SCRIPTNAME=`basename "$0"`

echo "################################################"
echo "  Running Management Server Setup ($SCRIPTNAME)..."
echo "################################################"
echo -e "\n This script was written for Vx."
echo " Detected vagrant user is: $username"


#######################
#       KNOBS
#######################

#Install Automation Tools
ansible_version=2.4.0.0

#######################

username=$(cat /tmp/normal_user)


install_ansible(){
    echo " ### Installing Ansible... ###"
    # apt-get install -qy build-essential sshpass libssh-dev python-dev libssl-dev libffi-dev
    # pip install pip --upgrade
    # pip install setuptools --upgrade
    # pip install ansible==$ansible_version --upgrade
}

## MOTD
echo " ### Overwriting MOTD ###"
cat <<EOT > /etc/motd.base64
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF8NChtbMDs0
MDszN20bWzZDG1szMW1fX19fX19fG1szN20gICAbWzE7MzJteBtbMG0gG1szMm14G1szN20gG1sz
Mm14G1szN20bWzI3Q3wgfA0KIBtbMzJtLl8bWzM3bSAgG1szMW08X19fX19fXxtbMTszM21+G1sw
bSAbWzMybXgbWzM3bSAbWzE7MzJtWBtbMG0gG1szMm14G1szN20gICBfX18gXyAgIF8gXyBfXyBf
X18gIF8gICBffCB8XyAgIF8gX19fDQobWzMybSgbWzM3bScgG1szMm1cG1szN20gIBtbMzJtLCcg
G1sxOzMzbXx8G1swOzMybSBgLBtbMzdtICAgIBtbMzJtIBtbMzdtICAgLyBfX3wgfCB8IHwgJ18g
YCBfIFx8IHwgfCB8IHwgfCB8IC8gX198DQogG1szMm1gLl86XhtbMzdtICAgG1sxOzMzbXx8G1sw
bSAgIBtbMzJtOj4bWzM3bRtbNUN8IChfX3wgfF98IHwgfCB8IHwgfCB8IHxffCB8IHwgfF98IFxf
XyBcDQobWzVDG1szMm1eVH5+fn5+flQbWzM3bScbWzdDXF9fX3xcX18sX3xffCB8X3wgfF98XF9f
LF98X3xcX18sX3xfX18vDQobWzVDG1szMm1+IhtbMzdtG1s1QxtbMzJtfiINChtbMzdtG1swMG0N
Cg0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KIw0KIyAgICAgICAgICAgICAgICAgICAgIE91dCBPZiBC
YW5kIE1hbmFnZW1lbnQgU3RhdGlvbg0KIw0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0K
EOT
base64 -d /etc/motd.base64 > /etc/motd
rm /etc/motd.base64
chmod 755 /etc/motd

echo " ### Overwriting /etc/network/interfaces ###"
cat <<EOT > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    alias Connects (via NAT) To the Internet

auto swp1
iface swp1
    alias Faces the Internal Management Network
    address 192.168.200.254/24

EOT

sudo ifreload -a

echo " ### Overwriting DNS Server to 8.8.8.8 ###"
#Required because the installation of DNSmasq throws off DNS momentarily
echo "nameserver 8.8.8.8" > /etc/resolv.conf

echo " ### Adding Jessie Repository... ###"
cat << EOT > /etc/apt/sources.list.d/jessie.list
deb  http://deb.debian.org/debian jessie main
deb-src  http://deb.debian.org/debian jessie main

deb  http://deb.debian.org/debian jessie-updates main
deb-src  http://deb.debian.org/debian jessie-updates main
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main

EOT


echo " ### Updating APT Repository... ###"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update -y

echo " ### Installing Packages... ###"
apt-get install -y htop isc-dhcp-server tree apache2 git python-pip dnsmasq apt-cacher-ng ntpdate ansible


echo " ### Installing Ansible ### "
install_ansible

echo " ### Configure NTP... ###"
echo <<EOT >> /etc/ntp.conf
driftfile /var/lib/ntp/ntp.drift
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

server pool.ntp.org

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod notrap nomodify nopeer noquery

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1
EOT



echo " ###Creating SSH keys for cumulus user ###"
mkdir /home/cumulus/.ssh
/usr/bin/ssh-keygen -b 2048 -t rsa -f /home/cumulus/.ssh/id_rsa -q -N ""
cp /home/cumulus/.ssh/id_rsa.pub /home/cumulus/.ssh/authorized_keys

# Copying Vagrant Insecure Key In
# echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
# echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /home/cumulus/.ssh/authorized_keys


chown -R cumulus:cumulus /home/cumulus/
chown -R cumulus:cumulus /home/cumulus/.ssh
chmod 700 /home/cumulus/.ssh/
chmod 600 /home/cumulus/.ssh/*
chown cumulus:cumulus /home/cumulus/.ssh/*

echo "<html><h1>You've come to the $HOSTNAME.</h1></html>" > /var/www/html/index.html

echo "Copying Key into /var/www/html..."
cp /home/cumulus/.ssh/id_rsa.pub /var/www/html/authorized_keys
chmod 777 -R /var/www/html/*

echo " ###Making cumulus passwordless sudo ###"
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

echo ' ### Setting UP NAT and Routing on MGMT server... ### '
echo -e '#!/bin/bash \n/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE' > /etc/rc.local
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/98-ipforward.conf

echo " ### creating .gitconfig for cumulus user"
cat <<EOT >> /home/cumulus/.gitconfig
[push]
  default = matching
[color]
    ui = true
[credential]
    helper = cache --timeout=3600
[core]
    editor = nano
EOT


echo " ### Pushing DHCP File ###"
cat << EOT > /etc/dhcp/dhcpd.conf
ddns-update-style none;

authoritative;

log-facility local7;

option www-server code 72 = ip-address;
option cumulus-provision-url code 239 = text;

# Create an option namespace called ONIE
# See: https://github.com/opencomputeproject/onie/wiki/Quick-Start-Guide#advanced-dhcp-2-vivsoonie/onie/
option space onie code width 1 length width 1;
# Define the code names and data types within the ONIE namespace
option onie.installer_url code 1 = text;
option onie.updater_url   code 2 = text;
option onie.machine       code 3 = text;
option onie.arch          code 4 = text;
option onie.machine_rev   code 5 = text;
# Package the ONIE namespace into option 125
option space vivso code width 4 length width 1;
option vivso.onie code 42623 = encapsulate onie;
option vivso.iana code 0 = string;
option op125 code 125 = encapsulate vivso;
class "onie-vendor-classes" {
  # Limit the matching to a request we know originated from ONIE
  match if substring(option vendor-class-identifier, 0, 11) = "onie_vendor";
  # Required to use VIVSO
  option vivso.iana 01:01:01;

  ### Example how to match a specific machine type ###
  #if option onie.machine = "" {
  #  option onie.installer_url = "";
  #  option onie.updater_url = "";
  #}
}

# OOB Management subnet
shared-network LOCAL-NET{

subnet 192.168.200.0 netmask 255.255.255.0 {
  range 192.168.200.1 192.168.200.250;
  option domain-name-servers 192.168.200.254;
  option domain-name "simulation";
  default-lease-time 172800;  #2 days
  max-lease-time 345600;      #4 days
  option www-server 192.168.200.254;
  option default-url = "http://192.168.200.254/onie-installer";
  option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh";
  option ntp-servers 192.168.200.254;
}

}

#include "/etc/dhcp/dhcpd.pools";
include "/etc/dhcp/dhcpd.hosts";
EOT

echo " ### Push DHCP Host Config ###"
cat << EOT > /etc/dhcp/dhcpd.hosts
group {

  option domain-name-servers 192.168.200.254;
  option domain-name "simulation";
  #option routers 192.168.200.254;
  option www-server 192.168.200.254;
  option default-url = "http://192.168.200.254/onie-installer";


host oob-mgmt-switch {hardware ethernet 44:38:39:00:04:49; fixed-address 192.168.200.25; option host-name "oob-mgmt-switch"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc1-1 {hardware ethernet 44:38:39:00:04:4c; fixed-address 192.168.200.1; option host-name "chassis02-lc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc1-1 {hardware ethernet 44:38:39:00:04:4e; fixed-address 192.168.200.2; option host-name "chassis03-lc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-fc1-1 {hardware ethernet 44:38:39:00:04:50; fixed-address 192.168.200.3; option host-name "chassis02-fc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc1-2 {hardware ethernet 44:38:39:00:04:52; fixed-address 192.168.200.4; option host-name "chassis02-lc1-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-fc3-1 {hardware ethernet 44:38:39:00:04:54; fixed-address 192.168.200.5; option host-name "chassis02-fc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc3-1 {hardware ethernet 44:38:39:00:04:56; fixed-address 192.168.200.6; option host-name "chassis03-lc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc2-2 {hardware ethernet 44:38:39:00:04:58; fixed-address 192.168.200.7; option host-name "chassis02-lc2-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-fc2-1 {hardware ethernet 44:38:39:00:04:5a; fixed-address 192.168.200.8; option host-name "chassis02-fc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc2-1 {hardware ethernet 44:38:39:00:04:5c; fixed-address 192.168.200.9; option host-name "chassis02-lc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc3-1 {hardware ethernet 44:38:39:00:04:5e; fixed-address 192.168.200.10; option host-name "chassis04-lc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-fc1-1 {hardware ethernet 44:38:39:00:04:60; fixed-address 192.168.200.11; option host-name "chassis04-fc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh";option routers 192.168.200.254;  }

host chassis03-fc4-1 {hardware ethernet 44:38:39:00:04:62; fixed-address 192.168.200.12; option host-name "chassis03-fc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc2-1 {hardware ethernet 44:38:39:00:04:6c; fixed-address 192.168.200.17; option host-name "chassis04-lc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc2-1 {hardware ethernet 44:38:39:00:04:6e; fixed-address 192.168.200.18; option host-name "chassis03-lc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-fc4-1 {hardware ethernet 44:38:39:00:04:72; fixed-address 192.168.200.20; option host-name "chassis01-fc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-fc1-1 {hardware ethernet 44:38:39:00:04:74; fixed-address 192.168.200.21; option host-name "chassis01-fc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc3-1 {hardware ethernet 44:38:39:00:04:76; fixed-address 192.168.200.22; option host-name "chassis02-lc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc3-2 {hardware ethernet 44:38:39:00:04:78; fixed-address 192.168.200.23; option host-name "chassis04-lc3-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc1-2 {hardware ethernet 44:38:39:00:04:7a; fixed-address 192.168.200.24; option host-name "chassis03-lc1-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-fc3-1 {hardware ethernet 44:38:39:00:04:7c; fixed-address 192.168.200.26; option host-name "chassis01-fc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc4-1 {hardware ethernet 44:38:39:00:04:7e; fixed-address 192.168.200.27; option host-name "chassis02-lc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc4-2 {hardware ethernet 44:38:39:00:04:80; fixed-address 192.168.200.28; option host-name "chassis02-lc4-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc3-2 {hardware ethernet 44:38:39:00:04:84; fixed-address 192.168.200.30; option host-name "chassis03-lc3-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-fc3-1 {hardware ethernet 44:38:39:00:04:86; fixed-address 192.168.200.31; option host-name "chassis04-fc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc2-2 {hardware ethernet 44:38:39:00:04:88; fixed-address 192.168.200.32; option host-name "chassis04-lc2-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-fc2-1 {hardware ethernet 44:38:39:00:04:8a; fixed-address 192.168.200.33; option host-name "chassis01-fc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-fc2-1 {hardware ethernet 44:38:39:00:04:8c; fixed-address 192.168.200.34; option host-name "chassis04-fc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-fc4-1 {hardware ethernet 44:38:39:00:04:8e; fixed-address 192.168.200.35; option host-name "chassis04-fc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-lc3-2 {hardware ethernet 44:38:39:00:04:9c; fixed-address 192.168.200.42; option host-name "chassis02-lc3-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-fc2-1 {hardware ethernet 44:38:39:00:04:9e; fixed-address 192.168.200.43; option host-name "chassis03-fc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc1-2 {hardware ethernet 44:38:39:00:04:a0; fixed-address 192.168.200.44; option host-name "chassis01-lc1-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-fc3-1 {hardware ethernet 44:38:39:00:04:a2; fixed-address 192.168.200.45; option host-name "chassis03-fc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc1-1 {hardware ethernet 44:38:39:00:04:a4; fixed-address 192.168.200.46; option host-name "chassis01-lc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc1-2 {hardware ethernet 44:38:39:00:04:a6; fixed-address 192.168.200.47; option host-name "chassis04-lc1-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc1-1 {hardware ethernet 44:38:39:00:04:a8; fixed-address 192.168.200.48; option host-name "chassis04-lc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh";  }

host chassis03-fc1-1 {hardware ethernet 44:38:39:00:04:aa; fixed-address 192.168.200.49; option host-name "chassis03-fc1-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc2-2 {hardware ethernet 44:38:39:00:04:ac; fixed-address 192.168.200.50; option host-name "chassis03-lc2-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc4-2 {hardware ethernet 44:38:39:00:04:ae; fixed-address 192.168.200.51; option host-name "chassis01-lc4-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc4-1 {hardware ethernet 44:38:39:00:04:b0; fixed-address 192.168.200.52; option host-name "chassis01-lc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc2-1 {hardware ethernet 44:38:39:00:04:b2; fixed-address 192.168.200.53; option host-name "chassis01-lc2-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc4-1 {hardware ethernet 44:38:39:00:04:b4; fixed-address 192.168.200.54; option host-name "chassis03-lc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc2-2 {hardware ethernet 44:38:39:00:04:b6; fixed-address 192.168.200.55; option host-name "chassis01-lc2-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc3-1 {hardware ethernet 44:38:39:00:04:b8; fixed-address 192.168.200.56; option host-name "chassis01-lc3-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis01-lc3-2 {hardware ethernet 44:38:39:00:04:ba; fixed-address 192.168.200.57; option host-name "chassis01-lc3-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis02-fc4-1 {hardware ethernet 44:38:39:00:04:bc; fixed-address 192.168.200.58; option host-name "chassis02-fc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis04-lc4-1 {hardware ethernet 44:38:39:00:04:be; fixed-address 192.168.200.59; option host-name "chassis04-lc4-1"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254;  }

host chassis04-lc4-2 {hardware ethernet 44:38:39:00:04:c0; fixed-address 192.168.200.60; option host-name "chassis04-lc4-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host chassis03-lc4-2 {hardware ethernet 44:38:39:00:04:c2; fixed-address 192.168.200.61; option host-name "chassis03-lc4-2"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf06 {hardware ethernet 44:38:39:00:04:90; fixed-address 192.168.200.36; option host-name "leaf06"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf04 {hardware ethernet 44:38:39:00:04:92; fixed-address 192.168.200.37; option host-name "leaf04"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf05 {hardware ethernet 44:38:39:00:04:94; fixed-address 192.168.200.38; option host-name "leaf05"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf02 {hardware ethernet 44:38:39:00:04:96; fixed-address 192.168.200.39; option host-name "leaf02"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf03 {hardware ethernet 44:38:39:00:04:98; fixed-address 192.168.200.40; option host-name "leaf03"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host leaf01 {hardware ethernet 44:38:39:00:04:9a; fixed-address 192.168.200.41; option host-name "leaf01"; option cumulus-provision-url "http://192.168.200.254/ztp_oob.sh"; option routers 192.168.200.254; }

host server01 {hardware ethernet 44:38:39:00:04:64; fixed-address 192.168.200.13; option host-name "server01"; }

host server03 {hardware ethernet 44:38:39:00:04:66; fixed-address 192.168.200.14; option host-name "server03"; }

host server02 {hardware ethernet 44:38:39:00:04:68; fixed-address 192.168.200.15; option host-name "server02"; }

host server05 {hardware ethernet 44:38:39:00:04:6a; fixed-address 192.168.200.16; option host-name "server05"; }

host server06 {hardware ethernet 44:38:39:00:04:70; fixed-address 192.168.200.19; option host-name "server06"; }

host server04 {hardware ethernet 44:38:39:00:04:82; fixed-address 192.168.200.29; option host-name "server04"; }
}#End of static host group
EOT

chmod 755 -R /etc/dhcp/*
systemctl enable dhcpd
systemctl restart dhcpd

echo " ### Push Hosts File ###"
cat << EOT > /etc/hosts
# Created by Topology-Converter v4.6.5
#    Template Revision: v4.6.5


127.0.0.1 localhost
127.0.1.1 oob-mgmt-server

192.168.200.254 oob-mgmt-server


192.168.200.25 oob-mgmt-switch
192.168.200.1 chassis02-lc1-1
192.168.200.2 chassis03-lc1-1
192.168.200.3 chassis02-fc1-1
192.168.200.4 chassis02-lc1-2
192.168.200.5 chassis02-fc3-1
192.168.200.6 chassis03-lc3-1
192.168.200.7 chassis02-lc2-2
192.168.200.8 chassis02-fc2-1
192.168.200.9 chassis02-lc2-1
192.168.200.10 chassis04-lc3-1
192.168.200.11 chassis04-fc1-1
192.168.200.12 chassis03-fc4-1
192.168.200.17 chassis04-lc2-1
192.168.200.18 chassis03-lc2-1
192.168.200.20 chassis01-fc4-1
192.168.200.21 chassis01-fc1-1
192.168.200.22 chassis02-lc3-1
192.168.200.23 chassis04-lc3-2
192.168.200.24 chassis03-lc1-2
192.168.200.26 chassis01-fc3-1
192.168.200.27 chassis02-lc4-1
192.168.200.28 chassis02-lc4-2
192.168.200.30 chassis03-lc3-2
192.168.200.31 chassis04-fc3-1
192.168.200.32 chassis04-lc2-2
192.168.200.33 chassis01-fc2-1
192.168.200.34 chassis04-fc2-1
192.168.200.35 chassis04-fc4-1
192.168.200.42 chassis02-lc3-2
192.168.200.43 chassis03-fc2-1
192.168.200.44 chassis01-lc1-2
192.168.200.45 chassis03-fc3-1
192.168.200.46 chassis01-lc1-1
192.168.200.47 chassis04-lc1-2
192.168.200.48 chassis04-lc1-1
192.168.200.49 chassis03-fc1-1
192.168.200.50 chassis03-lc2-2
192.168.200.51 chassis01-lc4-2
192.168.200.52 chassis01-lc4-1
192.168.200.53 chassis01-lc2-1
192.168.200.54 chassis03-lc4-1
192.168.200.55 chassis01-lc2-2
192.168.200.56 chassis01-lc3-1
192.168.200.57 chassis01-lc3-2
192.168.200.58 chassis02-fc4-1
192.168.200.59 chassis04-lc4-1
192.168.200.60 chassis04-lc4-2
192.168.200.61 chassis03-lc4-2
192.168.200.36 leaf06
192.168.200.37 leaf04
192.168.200.38 leaf05
192.168.200.39 leaf02
192.168.200.40 leaf03
192.168.200.41 leaf01
192.168.200.13 server01
192.168.200.14 server03
192.168.200.15 server02
192.168.200.16 server05
192.168.200.19 server06
192.168.200.29 server04


# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

EOT

systemctl enable dnsmasq.service
systemctl start dnsmasq.service

echo " ### Pushing ZTP Script ###"
cat << EOT > /var/www/html/ztp_oob.sh
#!/bin/bash

###################
# Simple ZTP Script
###################

function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed while running the command \$BASH_COMMAND at line \$BASH_LINENO.\e[0m" >&2
}
trap error ERR

#Setup SSH key authentication for Ansible
mkdir -p /home/cumulus/.ssh
wget -O /home/cumulus/.ssh/authorized_keys http://192.168.200.254/authorized_keys
#echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus/.ssh
chown cumulus:cumulus -R /home/cumulus/.ssh

echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

sed -i '/iface eth0/a \ vrf mgmt' /etc/network/interfaces
cat <<EOT >> /etc/network/interfaces
auto mgmt
iface mgmt
  address 127.0.0.1/8
  vrf-table auto
EOT


nohup bash -c 'sleep 2; shutdown now -r "Rebooting to Complete ZTP"' &
exit 0
#CUMULUS-AUTOPROVISIONING
EOT

apt-get clean -y

echo "############################################"
echo "      DONE!"
echo "############################################"
