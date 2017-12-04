#!/bin/bash
# Created by Topology-Converter v4.6.5
#    Template Revision: v4.6.5
#    https://github.com/cumulusnetworks/topology_converter
#    using topology data from: topology.dot

echo "################################################"
echo "  Running Automatic Management Server Setup..."
echo "################################################"
echo -e "\n This script assumes an Ubuntu16.04 server."
echo " Detected vagrant user is: $username"


#######################
#       KNOBS
#######################

REPOSITORY="https://github.com/CumulusNetworks/vagrant"
REPONAME="vagrant"

#Install Automation Tools
puppet=0
ansible=1
ansible_version=2.3.1.0

#######################

username=$(cat /tmp/normal_user)

install_puppet(){
    echo " ### Adding Puppet Repositories... ###"
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
    dpkg -i puppetlabs-release-pc1-xenial.deb
    echo " ### Updating APT Repository... ###"
    apt-get update -y
    echo " ### Installing Puppet ###"
    apt-get install puppetserver -qy
    echo " ### Setting up Puppet ###"
    rm -rf /etc/puppetlabs/code/environments/production
    sed -i 's/-Xms2g/-Xms512m/g' /etc/default/puppetserver
    sed -i 's/-Xmx2g/-Xmx512m/g' /etc/default/puppetserver
    echo "*" > /etc/puppetlabs/puppet/autosign.conf
    sed -i 's/192.168.200.254/192.168.200.254 puppet /g'>> /etc/hosts
}

install_ansible(){
    echo " ### Installing Ansible... ###"
    apt-get install -qy sshpass libssh-dev libffi-dev
    pip install pip --upgrade
    pip install setuptools --upgrade
    pip install ansible==$ansible_version --upgrade
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
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KIw0KIyAgICAgICAgIE91dCBPZiBCYW5kIE1hbmFnZW1l
bnQgU2VydmVyIChvb2ItbWdtdC1zZXJ2ZXIpDQojDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQo=
EOT
base64 -d /etc/motd.base64 > /etc/motd
rm /etc/motd.base64
chmod 755 /etc/motd


echo " ### Overwriting /etc/network/interfaces ###"
cat <<EOT > /etc/network/interfaces
auto lo
iface lo inet loopback


auto vagrant
iface vagrant inet dhcp


auto swp1
iface swp1
    address 192.168.200.254/24
EOT

echo " ### Overwriting DNS Server to 8.8.8.8 ###"
#Required because the installation of DNSmasq throws off DNS momentarily
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

echo " ### Updating APT Repository... ###"
echo 'deb http://deb.debian.org/debian/ oldstable main contrib non-free' | sudo tee -a /etc/apt/sources.list
echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' | sudo tee -a /etc/apt/sources.list

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update -y

echo " ### Installing Packages... ###"
apt-get install -y ansible htop apache2 git dnsmasq apt-cacher-ng


echo " ### Setting Up DHCP ###"
mv /home/$username/dhcpd.conf /etc/dhcp/dhcpd.conf
mv /home/$username/dhcpd.hosts /etc/dhcp/dhcpd.hosts
chmod 755 -R /etc/dhcp/*
systemctl restart isc-dhcp-server

echo " ### Setting up ZTP ###"
mv /home/$username/ztp_oob.sh /var/www/html/ztp_oob.sh

echo " ### Setting Up Hostfile ###"
mv /home/$username/hosts /etc/hosts

echo " ### Moving Ansible Hostfile into place ###"
mkdir -p /etc/ansible
mv /home/$username/ansible_hostfile /etc/ansible/hosts

echo " ###Creating SSH keys for cumulus user ###"
mkdir /home/cumulus/.ssh
/usr/bin/ssh-keygen -b 2048 -t rsa -f /home/cumulus/.ssh/id_rsa -q -N ""
cp /home/cumulus/.ssh/id_rsa.pub /home/cumulus/.ssh/authorized_keys

chown -R cumulus:cumulus /home/cumulus/
chown -R cumulus:cumulus /home/cumulus/.ssh
chmod 700 /home/cumulus/.ssh/
chmod 600 /home/cumulus/.ssh/*
chown cumulus:cumulus /home/cumulus/.ssh/*

echo "<html><h1>You've come to the OOB-MGMT-Server.</h1></html>" > /var/www/html/index.html

echo "Copying Key into /var/www/html..."
cp /home/cumulus/.ssh/id_rsa.pub /var/www/html/authorized_keys
chmod 777 -R /var/www/html/*

echo " ###Making cumulus passwordless sudo ###"
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

echo ' ### Setting UP NAT and Routing on MGMT server... ### '
echo -e '#!/bin/bash \n/sbin/iptables -t nat -A POSTROUTING -o vagrant -j MASQUERADE' > /etc/rc.local

echo " ### Creating turnup.sh script ###"
    cat <<EOT >> /home/cumulus/turnup.sh
git clone $REPOSITORY
EOT

if [ $puppet -eq 1 ]; then
    cat <<EOT >> /home/cumulus/turnup.sh
sudo rm -rf /etc/puppetlabs/code/environments/production
sudo ln -s  /home/cumulus/$REPONAME/puppet/ /etc/puppetlabs/code/environments/production
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-stdlib
#sudo bash -c 'echo "certname = 192.168.200.254" >> /etc/puppetlabs/puppet/puppet.conf'
echo " ### Starting PUPPET Master ###"
echo "     (this may take a while 30 secs or so...)"
sudo systemctl restart puppetserver.service
EOT
fi
if [ $ansible -eq 1 ]; then
    cat <<EOT >> /home/cumulus/turnup.sh
#Add any ansible specific steps here
EOT
fi

chmod +x /home/cumulus/turnup.sh

echo " ### creating .gitconfig for cumulus user"
cat <<EOT >> /home/cumulus/.gitconfig
[push]
  default = matching
[color]
    ui = true
[credential]
    helper = cache --timeout=3600
[core]
    editor = vim
EOT

echo "############################################"
echo "      DONE!"
echo "############################################"
