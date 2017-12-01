# Created by Topology-Converter v4.6.5
#    Template Revision: v4.6.5
#    https://github.com/cumulusnetworks/topology_converter
#    using topology data from: topology.dot
#    built with the following args: topology_converter.py topology.dot
#
#    NOTE: in order to use this Vagrantfile you will need:
#       -Vagrant(v1.8.6+) installed: http://www.vagrantup.com/downloads
#       -the "helper_scripts" directory that comes packaged with topology-converter.py
#       -Virtualbox installed: https://www.virtualbox.org/wiki/Downloads




$script = <<-SCRIPT
if grep -q -i 'cumulus' /etc/lsb-release &> /dev/null; then
    echo "### RUNNING CUMULUS EXTRA CONFIG ###"
    source /etc/lsb-release
    if [[ $DISTRIB_RELEASE =~ ^2.* ]]; then
        echo "  INFO: Detected a 2.5.x Based Release"

        echo "  adding fake cl-acltool..."
        echo -e "#!/bin/bash\nexit 0" > /usr/bin/cl-acltool
        chmod 755 /usr/bin/cl-acltool

        echo "  adding fake cl-license..."
        echo -e "#!/bin/bash\nexit 0" > /usr/bin/cl-license
        chmod 755 /usr/bin/cl-license

        echo "  Disabling default remap on Cumulus VX..."
        mv -v /etc/init.d/rename_eth_swp /etc/init.d/rename_eth_swp.backup

        echo "### Rebooting to Apply Remap..."

    elif [[ $DISTRIB_RELEASE =~ ^3.* ]]; then
        echo "  INFO: Detected a 3.x Based Release"
        echo "### Disabling default remap on Cumulus VX..."
        mv -v /etc/hw_init.d/S10rename_eth_swp.sh /etc/S10rename_eth_swp.sh.backup &> /dev/null
        echo "### Disabling ZTP service..."
        systemctl stop ztp.service
        ztp -d 2>&1
        echo "### Resetting ZTP to work next boot..."
        ztp -R 2>&1
        echo "  INFO: Detected Cumulus Linux v$DISTRIB_RELEASE Release"
        if [[ $DISTRIB_RELEASE =~ ^3.[1-9].* ]]; then
            echo "### Fixing ONIE DHCP to avoid Vagrant Interface ###"
            echo "     Note: Installing from ONIE will undo these changes." 
            mkdir /tmp/foo
            mount LABEL=ONIE-BOOT /tmp/foo
            sed -i 's/eth0/eth1/g' /tmp/foo/grub/grub.cfg
            sed -i 's/eth0/eth1/g' /tmp/foo/onie/grub/grub-extra.cfg
            umount /tmp/foo
        fi
        if [[ $DISTRIB_RELEASE =~ ^3.[2-9].* ]]; then
            if [[ $(grep "vagrant" /etc/netd.conf | wc -l ) == 0 ]]; then
                echo "### Giving Vagrant User Ability to Run NCLU Commands ###"
                sed -i 's/users_with_edit = root, cumulus/users_with_edit = root, cumulus, vagrant/g' /etc/netd.conf
                sed -i 's/users_with_show = root, cumulus/users_with_show = root, cumulus, vagrant/g' /etc/netd.conf
            fi
        fi

    fi
fi
echo "### DONE ###"
echo "### Rebooting Device to Apply Remap..."
nohup bash -c 'sleep 10; shutdown now -r "Rebooting to Remap Interfaces"' &
SCRIPT

Vagrant.configure("2") do |config|

  simid = 1512168624

  config.vm.provider "virtualbox" do |v|
    v.gui=false

  end




  ##### DEFINE VM for chassis02-lc1-1 #####
  config.vm.define "chassis02-lc1-1" do |device|
    
    device.vm.hostname = "chassis02-lc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net556", auto_config: false , :mac => "443839000449"
      
      # link for fp0 --> chassis02-fc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net299", auto_config: false , :mac => "443839000251"
      
      # link for fp1 --> chassis02-fc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net201", auto_config: false , :mac => "44383900018e"
      
      # link for fp2 --> chassis02-fc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net405", auto_config: false , :mac => "443839000323"
      
      # link for fp3 --> chassis02-fc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net117", auto_config: false , :mac => "4438390000e6"
      
      # link for fp4 --> chassis02-fc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net204", auto_config: false , :mac => "443839000194"
      
      # link for fp5 --> chassis02-fc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net109", auto_config: false , :mac => "4438390000d6"
      
      # link for fp6 --> chassis02-fc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net221", auto_config: false , :mac => "4438390001b6"
      
      # link for fp7 --> chassis02-fc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net460", auto_config: false , :mac => "44383900038f"
      
      # link for fp8 --> chassis02-fc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net160", auto_config: false , :mac => "44383900013c"
      
      # link for fp9 --> chassis02-fc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net396", auto_config: false , :mac => "443839000311"
      
      # link for fp10 --> chassis02-fc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net75", auto_config: false , :mac => "443839000093"
      
      # link for fp11 --> chassis02-fc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net338", auto_config: false , :mac => "44383900029d"
      
      # link for fp12 --> chassis02-fc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net403", auto_config: false , :mac => "44383900031f"
      
      # link for fp13 --> chassis02-fc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net409", auto_config: false , :mac => "44383900032b"
      
      # link for fp14 --> chassis02-fc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net422", auto_config: false , :mac => "443839000344"
      
      # link for fp15 --> chassis02-fc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net499", auto_config: false , :mac => "4438390003dc"
      
      # link for swp1 --> leaf01:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net237", auto_config: false , :mac => "4438390001d7"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:49 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:49", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:51 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:51", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8e --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8e", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:23 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:23", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e6 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e6", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:94 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:94", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d6 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d6", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b6 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b6", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8f --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8f", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3c --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3c", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:11 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:11", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:93 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:93", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9d --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9d", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1f --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1f", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2b --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2b", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:44 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:44", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:dc --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:dc", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d7 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d7", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc1-1 #####
  config.vm.define "chassis03-lc1-1" do |device|
    
    device.vm.hostname = "chassis03-lc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net557", auto_config: false , :mac => "44383900044a"
      
      # link for fp0 --> chassis03-fc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net444", auto_config: false , :mac => "44383900036f"
      
      # link for fp1 --> chassis03-fc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net192", auto_config: false , :mac => "44383900017c"
      
      # link for fp2 --> chassis03-fc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net481", auto_config: false , :mac => "4438390003b9"
      
      # link for fp3 --> chassis03-fc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net532", auto_config: false , :mac => "44383900041c"
      
      # link for fp4 --> chassis03-fc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net554", auto_config: false , :mac => "443839000447"
      
      # link for fp5 --> chassis03-fc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net304", auto_config: false , :mac => "44383900025a"
      
      # link for fp6 --> chassis03-fc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net105", auto_config: false , :mac => "4438390000ce"
      
      # link for fp7 --> chassis03-fc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net56", auto_config: false , :mac => "44383900006d"
      
      # link for fp8 --> chassis03-fc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net124", auto_config: false , :mac => "4438390000f4"
      
      # link for fp9 --> chassis03-fc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net231", auto_config: false , :mac => "4438390001ca"
      
      # link for fp10 --> chassis03-fc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net331", auto_config: false , :mac => "44383900028f"
      
      # link for fp11 --> chassis03-fc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net539", auto_config: false , :mac => "44383900042a"
      
      # link for fp12 --> chassis03-fc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net52", auto_config: false , :mac => "443839000065"
      
      # link for fp13 --> chassis03-fc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net83", auto_config: false , :mac => "4438390000a3"
      
      # link for fp14 --> chassis03-fc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net132", auto_config: false , :mac => "443839000104"
      
      # link for fp15 --> chassis03-fc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net310", auto_config: false , :mac => "443839000266"
      
      # link for swp1 --> leaf01:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net515", auto_config: false , :mac => "4438390003fc"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4a --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4a", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6f --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6f", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7c --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7c", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b9 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b9", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1c --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1c", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:47 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:47", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5a --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5a", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ce --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ce", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6d --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6d", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f4 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f4", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ca --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ca", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8f --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8f", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2a --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2a", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:65 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:65", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a3 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a3", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:04 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:04", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:66 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:66", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:fc --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:fc", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-fc1-1 #####
  config.vm.define "chassis02-fc1-1" do |device|
    
    device.vm.hostname = "chassis02-fc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-fc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net558", auto_config: false , :mac => "44383900044b"
      
      # link for fp0 --> chassis02-lc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net299", auto_config: false , :mac => "443839000252"
      
      # link for fp1 --> chassis02-lc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net201", auto_config: false , :mac => "44383900018f"
      
      # link for fp2 --> chassis02-lc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net405", auto_config: false , :mac => "443839000324"
      
      # link for fp3 --> chassis02-lc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net117", auto_config: false , :mac => "4438390000e7"
      
      # link for fp4 --> chassis02-lc1-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net453", auto_config: false , :mac => "443839000382"
      
      # link for fp5 --> chassis02-lc1-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net137", auto_config: false , :mac => "44383900010f"
      
      # link for fp6 --> chassis02-lc1-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net512", auto_config: false , :mac => "4438390003f6"
      
      # link for fp7 --> chassis02-lc1-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net329", auto_config: false , :mac => "44383900028c"
      
      # link for fp8 --> chassis02-lc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net218", auto_config: false , :mac => "4438390001b1"
      
      # link for fp9 --> chassis02-lc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net443", auto_config: false , :mac => "44383900036e"
      
      # link for fp10 --> chassis02-lc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net119", auto_config: false , :mac => "4438390000eb"
      
      # link for fp11 --> chassis02-lc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net251", auto_config: false , :mac => "4438390001f3"
      
      # link for fp12 --> chassis02-lc2-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net276", auto_config: false , :mac => "443839000225"
      
      # link for fp13 --> chassis02-lc2-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net77", auto_config: false , :mac => "443839000098"
      
      # link for fp14 --> chassis02-lc2-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net190", auto_config: false , :mac => "443839000179"
      
      # link for fp15 --> chassis02-lc2-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net234", auto_config: false , :mac => "4438390001d1"
      
      # link for fp16 --> chassis02-lc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net488", auto_config: false , :mac => "4438390003c8"
      
      # link for fp17 --> chassis02-lc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net400", auto_config: false , :mac => "44383900031a"
      
      # link for fp18 --> chassis02-lc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net448", auto_config: false , :mac => "443839000378"
      
      # link for fp19 --> chassis02-lc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net66", auto_config: false , :mac => "443839000082"
      
      # link for fp20 --> chassis02-lc3-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net99", auto_config: false , :mac => "4438390000c3"
      
      # link for fp21 --> chassis02-lc3-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net281", auto_config: false , :mac => "44383900022e"
      
      # link for fp22 --> chassis02-lc3-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net301", auto_config: false , :mac => "443839000256"
      
      # link for fp23 --> chassis02-lc3-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net126", auto_config: false , :mac => "4438390000f9"
      
      # link for fp24 --> chassis02-lc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net63", auto_config: false , :mac => "44383900007c"
      
      # link for fp25 --> chassis02-lc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net43", auto_config: false , :mac => "443839000054"
      
      # link for fp26 --> chassis02-lc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net279", auto_config: false , :mac => "44383900022a"
      
      # link for fp27 --> chassis02-lc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net336", auto_config: false , :mac => "44383900029a"
      
      # link for fp28 --> chassis02-lc4-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net261", auto_config: false , :mac => "443839000207"
      
      # link for fp29 --> chassis02-lc4-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net112", auto_config: false , :mac => "4438390000dd"
      
      # link for fp30 --> chassis02-lc4-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net121", auto_config: false , :mac => "4438390000ef"
      
      # link for fp31 --> chassis02-lc4-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net145", auto_config: false , :mac => "44383900011f"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4b --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4b", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:52 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:52", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8f --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8f", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:24 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:24", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e7 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e7", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:82 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:82", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0f --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0f", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f6 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f6", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8c --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8c", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b1 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b1", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:eb --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:eb", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f3 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f3", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:25 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:25", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:98 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:98", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:79 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:79", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d1 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d1", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c8 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c8", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1a --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1a", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:78 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:78", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:82 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:82", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c3 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c3", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2e --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2e", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:56 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:56", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f9 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f9", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7c --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7c", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:54 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:54", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2a --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2a", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9a --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9a", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:07 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:07", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:dd --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:dd", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ef --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ef", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1f --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1f", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc1-2 #####
  config.vm.define "chassis02-lc1-2" do |device|
    
    device.vm.hostname = "chassis02-lc1-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc1-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net559", auto_config: false , :mac => "44383900044c"
      
      # link for fp0 --> chassis02-fc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net453", auto_config: false , :mac => "443839000381"
      
      # link for fp1 --> chassis02-fc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net137", auto_config: false , :mac => "44383900010e"
      
      # link for fp2 --> chassis02-fc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net512", auto_config: false , :mac => "4438390003f5"
      
      # link for fp3 --> chassis02-fc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net329", auto_config: false , :mac => "44383900028b"
      
      # link for fp4 --> chassis02-fc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net529", auto_config: false , :mac => "443839000417"
      
      # link for fp5 --> chassis02-fc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net380", auto_config: false , :mac => "4438390002f1"
      
      # link for fp6 --> chassis02-fc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net9", auto_config: false , :mac => "443839000011"
      
      # link for fp7 --> chassis02-fc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net55", auto_config: false , :mac => "44383900006b"
      
      # link for fp8 --> chassis02-fc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net127", auto_config: false , :mac => "4438390000fa"
      
      # link for fp9 --> chassis02-fc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net255", auto_config: false , :mac => "4438390001fa"
      
      # link for fp10 --> chassis02-fc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net241", auto_config: false , :mac => "4438390001de"
      
      # link for fp11 --> chassis02-fc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net269", auto_config: false , :mac => "443839000216"
      
      # link for fp12 --> chassis02-fc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net356", auto_config: false , :mac => "4438390002c1"
      
      # link for fp13 --> chassis02-fc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net376", auto_config: false , :mac => "4438390002e9"
      
      # link for fp14 --> chassis02-fc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net461", auto_config: false , :mac => "443839000391"
      
      # link for fp15 --> chassis02-fc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net423", auto_config: false , :mac => "443839000346"
      
      # link for swp2 --> leaf02:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net21", auto_config: false , :mac => "44383900002a"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4c --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4c", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:81 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:81", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0e --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0e", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f5 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f5", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8b --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8b", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:17 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:17", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f1 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f1", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:11 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:11", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6b --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6b", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:fa --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:fa", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:fa --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:fa", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:de --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:de", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:16 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:16", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c1 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c1", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e9 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e9", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:91 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:91", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:46 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:46", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2a --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2a", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-fc3-1 #####
  config.vm.define "chassis02-fc3-1" do |device|
    
    device.vm.hostname = "chassis02-fc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-fc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net560", auto_config: false , :mac => "44383900044d"
      
      # link for fp0 --> chassis02-lc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net160", auto_config: false , :mac => "44383900013d"
      
      # link for fp1 --> chassis02-lc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net396", auto_config: false , :mac => "443839000312"
      
      # link for fp2 --> chassis02-lc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net75", auto_config: false , :mac => "443839000094"
      
      # link for fp3 --> chassis02-lc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net338", auto_config: false , :mac => "44383900029e"
      
      # link for fp4 --> chassis02-lc1-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net127", auto_config: false , :mac => "4438390000fb"
      
      # link for fp5 --> chassis02-lc1-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net255", auto_config: false , :mac => "4438390001fb"
      
      # link for fp6 --> chassis02-lc1-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net241", auto_config: false , :mac => "4438390001df"
      
      # link for fp7 --> chassis02-lc1-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net269", auto_config: false , :mac => "443839000217"
      
      # link for fp8 --> chassis02-lc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net87", auto_config: false , :mac => "4438390000ab"
      
      # link for fp9 --> chassis02-lc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net368", auto_config: false , :mac => "4438390002da"
      
      # link for fp10 --> chassis02-lc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net79", auto_config: false , :mac => "44383900009c"
      
      # link for fp11 --> chassis02-lc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net350", auto_config: false , :mac => "4438390002b6"
      
      # link for fp12 --> chassis02-lc2-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net433", auto_config: false , :mac => "44383900035b"
      
      # link for fp13 --> chassis02-lc2-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net290", auto_config: false , :mac => "443839000240"
      
      # link for fp14 --> chassis02-lc2-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net28", auto_config: false , :mac => "443839000037"
      
      # link for fp15 --> chassis02-lc2-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net102", auto_config: false , :mac => "4438390000c9"
      
      # link for fp16 --> chassis02-lc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net54", auto_config: false , :mac => "44383900006a"
      
      # link for fp17 --> chassis02-lc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net288", auto_config: false , :mac => "44383900023c"
      
      # link for fp18 --> chassis02-lc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net332", auto_config: false , :mac => "443839000292"
      
      # link for fp19 --> chassis02-lc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net510", auto_config: false , :mac => "4438390003f2"
      
      # link for fp20 --> chassis02-lc3-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net131", auto_config: false , :mac => "443839000103"
      
      # link for fp21 --> chassis02-lc3-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net128", auto_config: false , :mac => "4438390000fd"
      
      # link for fp22 --> chassis02-lc3-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net57", auto_config: false , :mac => "443839000070"
      
      # link for fp23 --> chassis02-lc3-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net263", auto_config: false , :mac => "44383900020b"
      
      # link for fp24 --> chassis02-lc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net430", auto_config: false , :mac => "443839000355"
      
      # link for fp25 --> chassis02-lc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net505", auto_config: false , :mac => "4438390003e9"
      
      # link for fp26 --> chassis02-lc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net466", auto_config: false , :mac => "44383900039c"
      
      # link for fp27 --> chassis02-lc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net479", auto_config: false , :mac => "4438390003b6"
      
      # link for fp28 --> chassis02-lc4-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net363", auto_config: false , :mac => "4438390002d0"
      
      # link for fp29 --> chassis02-lc4-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net203", auto_config: false , :mac => "443839000193"
      
      # link for fp30 --> chassis02-lc4-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net419", auto_config: false , :mac => "44383900033f"
      
      # link for fp31 --> chassis02-lc4-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net157", auto_config: false , :mac => "443839000137"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4d --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4d", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3d --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3d", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:12 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:12", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:94 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:94", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9e --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9e", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:fb --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:fb", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:fb --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:fb", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:df --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:df", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:17 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:17", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ab --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ab", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:da --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:da", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9c --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9c", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b6 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b6", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5b --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5b", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:40 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:40", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:37 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:37", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c9 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c9", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6a --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6a", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3c --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3c", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:92 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:92", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f2 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f2", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:03 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:03", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:fd --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:fd", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:70 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:70", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0b --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0b", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:55 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:55", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e9 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e9", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9c --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9c", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b6 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b6", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d0 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d0", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:93 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:93", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3f --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3f", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:37 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:37", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc3-1 #####
  config.vm.define "chassis03-lc3-1" do |device|
    
    device.vm.hostname = "chassis03-lc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net561", auto_config: false , :mac => "44383900044e"
      
      # link for fp0 --> chassis03-fc1-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net407", auto_config: false , :mac => "443839000327"
      
      # link for fp1 --> chassis03-fc1-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net441", auto_config: false , :mac => "443839000369"
      
      # link for fp2 --> chassis03-fc1-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net472", auto_config: false , :mac => "4438390003a7"
      
      # link for fp3 --> chassis03-fc1-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net227", auto_config: false , :mac => "4438390001c2"
      
      # link for fp4 --> chassis03-fc2-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net107", auto_config: false , :mac => "4438390000d2"
      
      # link for fp5 --> chassis03-fc2-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net346", auto_config: false , :mac => "4438390002ad"
      
      # link for fp6 --> chassis03-fc2-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net245", auto_config: false , :mac => "4438390001e6"
      
      # link for fp7 --> chassis03-fc2-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net216", auto_config: false , :mac => "4438390001ac"
      
      # link for fp8 --> chassis03-fc3-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net153", auto_config: false , :mac => "44383900012e"
      
      # link for fp9 --> chassis03-fc3-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net90", auto_config: false , :mac => "4438390000b0"
      
      # link for fp10 --> chassis03-fc3-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net335", auto_config: false , :mac => "443839000297"
      
      # link for fp11 --> chassis03-fc3-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net485", auto_config: false , :mac => "4438390003c1"
      
      # link for fp12 --> chassis03-fc4-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net469", auto_config: false , :mac => "4438390003a1"
      
      # link for fp13 --> chassis03-fc4-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net416", auto_config: false , :mac => "443839000339"
      
      # link for fp14 --> chassis03-fc4-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net172", auto_config: false , :mac => "443839000154"
      
      # link for fp15 --> chassis03-fc4-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net447", auto_config: false , :mac => "443839000375"
      
      # link for swp5 --> leaf05:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net148", auto_config: false , :mac => "443839000125"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4e --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4e", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:27 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:27", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:69 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:69", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a7 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a7", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c2 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c2", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d2 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d2", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ad --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ad", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e6 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e6", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ac --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ac", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2e --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2e", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b0 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b0", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:97 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:97", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c1 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c1", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a1 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a1", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:39 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:39", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:54 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:54", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:75 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:75", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:25 --> swp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:25", NAME="swp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc2-2 #####
  config.vm.define "chassis02-lc2-2" do |device|
    
    device.vm.hostname = "chassis02-lc2-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc2-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net562", auto_config: false , :mac => "44383900044f"
      
      # link for fp0 --> chassis02-fc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net276", auto_config: false , :mac => "443839000224"
      
      # link for fp1 --> chassis02-fc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net77", auto_config: false , :mac => "443839000097"
      
      # link for fp2 --> chassis02-fc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net190", auto_config: false , :mac => "443839000178"
      
      # link for fp3 --> chassis02-fc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net234", auto_config: false , :mac => "4438390001d0"
      
      # link for fp4 --> chassis02-fc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net425", auto_config: false , :mac => "44383900034a"
      
      # link for fp5 --> chassis02-fc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net322", auto_config: false , :mac => "44383900027d"
      
      # link for fp6 --> chassis02-fc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net194", auto_config: false , :mac => "443839000180"
      
      # link for fp7 --> chassis02-fc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net327", auto_config: false , :mac => "443839000287"
      
      # link for fp8 --> chassis02-fc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net433", auto_config: false , :mac => "44383900035a"
      
      # link for fp9 --> chassis02-fc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net290", auto_config: false , :mac => "44383900023f"
      
      # link for fp10 --> chassis02-fc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net28", auto_config: false , :mac => "443839000036"
      
      # link for fp11 --> chassis02-fc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net102", auto_config: false , :mac => "4438390000c8"
      
      # link for fp12 --> chassis02-fc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net439", auto_config: false , :mac => "443839000365"
      
      # link for fp13 --> chassis02-fc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net490", auto_config: false , :mac => "4438390003cb"
      
      # link for fp14 --> chassis02-fc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net526", auto_config: false , :mac => "443839000411"
      
      # link for fp15 --> chassis02-fc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net312", auto_config: false , :mac => "44383900026a"
      
      # link for swp4 --> leaf04:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net462", auto_config: false , :mac => "443839000394"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:4f --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:4f", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:24 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:24", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:97 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:97", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:78 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:78", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d0 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d0", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4a --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4a", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7d --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7d", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:80 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:80", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:87 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:87", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5a --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5a", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3f --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3f", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:36 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:36", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c8 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c8", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:65 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:65", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:cb --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:cb", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:11 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:11", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6a --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6a", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:94 --> swp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:94", NAME="swp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-fc2-1 #####
  config.vm.define "chassis02-fc2-1" do |device|
    
    device.vm.hostname = "chassis02-fc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-fc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net563", auto_config: false , :mac => "443839000450"
      
      # link for fp0 --> chassis02-lc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net204", auto_config: false , :mac => "443839000195"
      
      # link for fp1 --> chassis02-lc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net109", auto_config: false , :mac => "4438390000d7"
      
      # link for fp2 --> chassis02-lc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net221", auto_config: false , :mac => "4438390001b7"
      
      # link for fp3 --> chassis02-lc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net460", auto_config: false , :mac => "443839000390"
      
      # link for fp4 --> chassis02-lc1-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net529", auto_config: false , :mac => "443839000418"
      
      # link for fp5 --> chassis02-lc1-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net380", auto_config: false , :mac => "4438390002f2"
      
      # link for fp6 --> chassis02-lc1-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net9", auto_config: false , :mac => "443839000012"
      
      # link for fp7 --> chassis02-lc1-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net55", auto_config: false , :mac => "44383900006c"
      
      # link for fp8 --> chassis02-lc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net294", auto_config: false , :mac => "443839000248"
      
      # link for fp9 --> chassis02-lc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net296", auto_config: false , :mac => "44383900024c"
      
      # link for fp10 --> chassis02-lc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net383", auto_config: false , :mac => "4438390002f8"
      
      # link for fp11 --> chassis02-lc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net410", auto_config: false , :mac => "44383900032e"
      
      # link for fp12 --> chassis02-lc2-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net425", auto_config: false , :mac => "44383900034b"
      
      # link for fp13 --> chassis02-lc2-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net322", auto_config: false , :mac => "44383900027e"
      
      # link for fp14 --> chassis02-lc2-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net194", auto_config: false , :mac => "443839000181"
      
      # link for fp15 --> chassis02-lc2-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net327", auto_config: false , :mac => "443839000288"
      
      # link for fp16 --> chassis02-lc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net395", auto_config: false , :mac => "443839000310"
      
      # link for fp17 --> chassis02-lc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net206", auto_config: false , :mac => "443839000199"
      
      # link for fp18 --> chassis02-lc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net319", auto_config: false , :mac => "443839000278"
      
      # link for fp19 --> chassis02-lc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net47", auto_config: false , :mac => "44383900005c"
      
      # link for fp20 --> chassis02-lc3-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net158", auto_config: false , :mac => "443839000139"
      
      # link for fp21 --> chassis02-lc3-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net475", auto_config: false , :mac => "4438390003ae"
      
      # link for fp22 --> chassis02-lc3-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net547", auto_config: false , :mac => "44383900043b"
      
      # link for fp23 --> chassis02-lc3-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net123", auto_config: false , :mac => "4438390000f3"
      
      # link for fp24 --> chassis02-lc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net361", auto_config: false , :mac => "4438390002cc"
      
      # link for fp25 --> chassis02-lc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net248", auto_config: false , :mac => "4438390001ed"
      
      # link for fp26 --> chassis02-lc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net325", auto_config: false , :mac => "443839000284"
      
      # link for fp27 --> chassis02-lc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net91", auto_config: false , :mac => "4438390000b3"
      
      # link for fp28 --> chassis02-lc4-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net88", auto_config: false , :mac => "4438390000ad"
      
      # link for fp29 --> chassis02-lc4-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net455", auto_config: false , :mac => "443839000386"
      
      # link for fp30 --> chassis02-lc4-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net85", auto_config: false , :mac => "4438390000a8"
      
      # link for fp31 --> chassis02-lc4-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net175", auto_config: false , :mac => "44383900015b"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:50 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:50", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:95 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:95", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d7 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d7", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b7 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b7", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:90 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:90", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:18 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:18", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f2 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f2", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:12 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:12", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6c --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6c", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:48 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:48", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4c --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4c", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f8 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f8", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2e --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2e", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4b --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4b", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7e --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7e", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:81 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:81", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:88 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:88", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:10 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:10", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:99 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:99", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:78 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:78", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5c --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5c", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:39 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:39", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ae --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ae", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3b --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3b", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f3 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f3", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:cc --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:cc", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ed --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ed", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:84 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:84", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b3 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b3", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ad --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ad", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:86 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:86", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a8 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a8", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5b --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5b", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc2-1 #####
  config.vm.define "chassis02-lc2-1" do |device|
    
    device.vm.hostname = "chassis02-lc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net564", auto_config: false , :mac => "443839000451"
      
      # link for fp0 --> chassis02-fc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net218", auto_config: false , :mac => "4438390001b0"
      
      # link for fp1 --> chassis02-fc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net443", auto_config: false , :mac => "44383900036d"
      
      # link for fp2 --> chassis02-fc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net119", auto_config: false , :mac => "4438390000ea"
      
      # link for fp3 --> chassis02-fc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net251", auto_config: false , :mac => "4438390001f2"
      
      # link for fp4 --> chassis02-fc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net294", auto_config: false , :mac => "443839000247"
      
      # link for fp5 --> chassis02-fc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net296", auto_config: false , :mac => "44383900024b"
      
      # link for fp6 --> chassis02-fc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net383", auto_config: false , :mac => "4438390002f7"
      
      # link for fp7 --> chassis02-fc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net410", auto_config: false , :mac => "44383900032d"
      
      # link for fp8 --> chassis02-fc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net87", auto_config: false , :mac => "4438390000aa"
      
      # link for fp9 --> chassis02-fc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net368", auto_config: false , :mac => "4438390002d9"
      
      # link for fp10 --> chassis02-fc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net79", auto_config: false , :mac => "44383900009b"
      
      # link for fp11 --> chassis02-fc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net350", auto_config: false , :mac => "4438390002b5"
      
      # link for fp12 --> chassis02-fc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net19", auto_config: false , :mac => "443839000025"
      
      # link for fp13 --> chassis02-fc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net348", auto_config: false , :mac => "4438390002b1"
      
      # link for fp14 --> chassis02-fc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net286", auto_config: false , :mac => "443839000237"
      
      # link for fp15 --> chassis02-fc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net250", auto_config: false , :mac => "4438390001f0"
      
      # link for swp3 --> leaf03:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net12", auto_config: false , :mac => "443839000018"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:51 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:51", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b0 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b0", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6d --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6d", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ea --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ea", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f2 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f2", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:47 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:47", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4b --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4b", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f7 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f7", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2d --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2d", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:aa --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:aa", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d9 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d9", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9b --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9b", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b5 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b5", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:25 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:25", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b1 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b1", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:37 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:37", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f0 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f0", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:18 --> swp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:18", NAME="swp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc3-1 #####
  config.vm.define "chassis04-lc3-1" do |device|
    
    device.vm.hostname = "chassis04-lc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net565", auto_config: false , :mac => "443839000452"
      
      # link for fp0 --> chassis04-fc1-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net265", auto_config: false , :mac => "44383900020e"
      
      # link for fp1 --> chassis04-fc1-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net48", auto_config: false , :mac => "44383900005d"
      
      # link for fp2 --> chassis04-fc1-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net260", auto_config: false , :mac => "443839000204"
      
      # link for fp3 --> chassis04-fc1-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net305", auto_config: false , :mac => "44383900025c"
      
      # link for fp4 --> chassis04-fc2-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net161", auto_config: false , :mac => "44383900013e"
      
      # link for fp5 --> chassis04-fc2-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net436", auto_config: false , :mac => "44383900035f"
      
      # link for fp6 --> chassis04-fc2-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net222", auto_config: false , :mac => "4438390001b8"
      
      # link for fp7 --> chassis04-fc2-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net72", auto_config: false , :mac => "44383900008d"
      
      # link for fp8 --> chassis04-fc3-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net459", auto_config: false , :mac => "44383900038d"
      
      # link for fp9 --> chassis04-fc3-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net240", auto_config: false , :mac => "4438390001dc"
      
      # link for fp10 --> chassis04-fc3-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net492", auto_config: false , :mac => "4438390003cf"
      
      # link for fp11 --> chassis04-fc3-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net36", auto_config: false , :mac => "443839000046"
      
      # link for fp12 --> chassis04-fc4-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net49", auto_config: false , :mac => "44383900005f"
      
      # link for fp13 --> chassis04-fc4-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net95", auto_config: false , :mac => "4438390000ba"
      
      # link for fp14 --> chassis04-fc4-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net213", auto_config: false , :mac => "4438390001a6"
      
      # link for fp15 --> chassis04-fc4-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net546", auto_config: false , :mac => "443839000438"
      
      # link for swp5 --> leaf05:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net225", auto_config: false , :mac => "4438390001bf"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:52 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:52", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0e --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0e", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5d --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5d", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:04 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:04", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5c --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5c", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3e --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3e", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5f --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5f", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b8 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b8", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8d --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8d", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8d --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8d", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:dc --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:dc", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:cf --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:cf", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:46 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:46", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5f --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5f", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ba --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ba", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a6 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a6", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:38 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:38", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:bf --> swp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:bf", NAME="swp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-fc1-1 #####
  config.vm.define "chassis04-fc1-1" do |device|
    
    device.vm.hostname = "chassis04-fc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-fc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net566", auto_config: false , :mac => "443839000453"
      
      # link for fp0 --> chassis04-lc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net385", auto_config: false , :mac => "4438390002fc"
      
      # link for fp1 --> chassis04-lc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net104", auto_config: false , :mac => "4438390000cd"
      
      # link for fp2 --> chassis04-lc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net271", auto_config: false , :mac => "44383900021b"
      
      # link for fp3 --> chassis04-lc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net65", auto_config: false , :mac => "443839000080"
      
      # link for fp4 --> chassis04-lc1-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net377", auto_config: false , :mac => "4438390002ec"
      
      # link for fp5 --> chassis04-lc1-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net353", auto_config: false , :mac => "4438390002bc"
      
      # link for fp6 --> chassis04-lc1-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net352", auto_config: false , :mac => "4438390002ba"
      
      # link for fp7 --> chassis04-lc1-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net392", auto_config: false , :mac => "44383900030a"
      
      # link for fp8 --> chassis04-lc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net504", auto_config: false , :mac => "4438390003e7"
      
      # link for fp9 --> chassis04-lc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net179", auto_config: false , :mac => "443839000163"
      
      # link for fp10 --> chassis04-lc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net375", auto_config: false , :mac => "4438390002e8"
      
      # link for fp11 --> chassis04-lc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net398", auto_config: false , :mac => "443839000316"
      
      # link for fp12 --> chassis04-lc2-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net514", auto_config: false , :mac => "4438390003fa"
      
      # link for fp13 --> chassis04-lc2-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net324", auto_config: false , :mac => "443839000282"
      
      # link for fp14 --> chassis04-lc2-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net521", auto_config: false , :mac => "443839000408"
      
      # link for fp15 --> chassis04-lc2-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net491", auto_config: false , :mac => "4438390003ce"
      
      # link for fp16 --> chassis04-lc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net265", auto_config: false , :mac => "44383900020f"
      
      # link for fp17 --> chassis04-lc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net48", auto_config: false , :mac => "44383900005e"
      
      # link for fp18 --> chassis04-lc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net260", auto_config: false , :mac => "443839000205"
      
      # link for fp19 --> chassis04-lc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net305", auto_config: false , :mac => "44383900025d"
      
      # link for fp20 --> chassis04-lc3-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net364", auto_config: false , :mac => "4438390002d2"
      
      # link for fp21 --> chassis04-lc3-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net343", auto_config: false , :mac => "4438390002a8"
      
      # link for fp22 --> chassis04-lc3-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net291", auto_config: false , :mac => "443839000242"
      
      # link for fp23 --> chassis04-lc3-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net452", auto_config: false , :mac => "443839000380"
      
      # link for fp24 --> chassis04-lc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net187", auto_config: false , :mac => "443839000173"
      
      # link for fp25 --> chassis04-lc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net142", auto_config: false , :mac => "443839000119"
      
      # link for fp26 --> chassis04-lc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net397", auto_config: false , :mac => "443839000314"
      
      # link for fp27 --> chassis04-lc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net93", auto_config: false , :mac => "4438390000b7"
      
      # link for fp28 --> chassis04-lc4-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net74", auto_config: false , :mac => "443839000092"
      
      # link for fp29 --> chassis04-lc4-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net138", auto_config: false , :mac => "443839000111"
      
      # link for fp30 --> chassis04-lc4-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net144", auto_config: false , :mac => "44383900011d"
      
      # link for fp31 --> chassis04-lc4-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net489", auto_config: false , :mac => "4438390003ca"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:53 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:53", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:fc --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:fc", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:cd --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:cd", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1b --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1b", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:80 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:80", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ec --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ec", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:bc --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:bc", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ba --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ba", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e7 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e7", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:63 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:63", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e8 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e8", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:16 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:16", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:fa --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:fa", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:82 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:82", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:08 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:08", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ce --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ce", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0f --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0f", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5e --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5e", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:05 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:05", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5d --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5d", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d2 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d2", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a8 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a8", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:42 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:42", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:80 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:80", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:73 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:73", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:19 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:19", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:14 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:14", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b7 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b7", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:92 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:92", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:11 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:11", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1d --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1d", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ca --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ca", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-fc4-1 #####
  config.vm.define "chassis03-fc4-1" do |device|
    
    device.vm.hostname = "chassis03-fc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-fc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net567", auto_config: false , :mac => "443839000454"
      
      # link for fp0 --> chassis03-lc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net52", auto_config: false , :mac => "443839000066"
      
      # link for fp1 --> chassis03-lc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net83", auto_config: false , :mac => "4438390000a4"
      
      # link for fp2 --> chassis03-lc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net132", auto_config: false , :mac => "443839000105"
      
      # link for fp3 --> chassis03-lc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net310", auto_config: false , :mac => "443839000267"
      
      # link for fp4 --> chassis03-lc1-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net259", auto_config: false , :mac => "443839000203"
      
      # link for fp5 --> chassis03-lc1-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net320", auto_config: false , :mac => "44383900027a"
      
      # link for fp6 --> chassis03-lc1-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net285", auto_config: false , :mac => "443839000236"
      
      # link for fp7 --> chassis03-lc1-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net101", auto_config: false , :mac => "4438390000c7"
      
      # link for fp8 --> chassis03-lc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net228", auto_config: false , :mac => "4438390001c5"
      
      # link for fp9 --> chassis03-lc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net94", auto_config: false , :mac => "4438390000b9"
      
      # link for fp10 --> chassis03-lc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net470", auto_config: false , :mac => "4438390003a4"
      
      # link for fp11 --> chassis03-lc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net454", auto_config: false , :mac => "443839000384"
      
      # link for fp12 --> chassis03-lc2-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net478", auto_config: false , :mac => "4438390003b4"
      
      # link for fp13 --> chassis03-lc2-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net183", auto_config: false , :mac => "44383900016b"
      
      # link for fp14 --> chassis03-lc2-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net136", auto_config: false , :mac => "44383900010d"
      
      # link for fp15 --> chassis03-lc2-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net257", auto_config: false , :mac => "4438390001ff"
      
      # link for fp16 --> chassis03-lc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net469", auto_config: false , :mac => "4438390003a2"
      
      # link for fp17 --> chassis03-lc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net416", auto_config: false , :mac => "44383900033a"
      
      # link for fp18 --> chassis03-lc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net172", auto_config: false , :mac => "443839000155"
      
      # link for fp19 --> chassis03-lc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net447", auto_config: false , :mac => "443839000376"
      
      # link for fp20 --> chassis03-lc3-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net98", auto_config: false , :mac => "4438390000c1"
      
      # link for fp21 --> chassis03-lc3-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net180", auto_config: false , :mac => "443839000165"
      
      # link for fp22 --> chassis03-lc3-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net483", auto_config: false , :mac => "4438390003be"
      
      # link for fp23 --> chassis03-lc3-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net17", auto_config: false , :mac => "443839000022"
      
      # link for fp24 --> chassis03-lc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net542", auto_config: false , :mac => "443839000431"
      
      # link for fp25 --> chassis03-lc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net549", auto_config: false , :mac => "44383900043f"
      
      # link for fp26 --> chassis03-lc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net550", auto_config: false , :mac => "443839000441"
      
      # link for fp27 --> chassis03-lc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net67", auto_config: false , :mac => "443839000084"
      
      # link for fp28 --> chassis03-lc4-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net384", auto_config: false , :mac => "4438390002fa"
      
      # link for fp29 --> chassis03-lc4-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net166", auto_config: false , :mac => "443839000149"
      
      # link for fp30 --> chassis03-lc4-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net215", auto_config: false , :mac => "4438390001ab"
      
      # link for fp31 --> chassis03-lc4-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net45", auto_config: false , :mac => "443839000058"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:54 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:54", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:66 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:66", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a4 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a4", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:05 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:05", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:67 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:67", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:03 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:03", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7a --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7a", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:36 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:36", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c7 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c7", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c5 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c5", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b9 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b9", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a4 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a4", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:84 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:84", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b4 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b4", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6b --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6b", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0d --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0d", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ff --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ff", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a2 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a2", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3a --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3a", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:55 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:55", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:76 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:76", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c1 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c1", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:65 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:65", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:be --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:be", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:22 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:22", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:31 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:31", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3f --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3f", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:41 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:41", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:84 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:84", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:fa --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:fa", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:49 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:49", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ab --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ab", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:58 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:58", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc2-1 #####
  config.vm.define "chassis04-lc2-1" do |device|
    
    device.vm.hostname = "chassis04-lc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net568", auto_config: false , :mac => "443839000455"
      
      # link for fp0 --> chassis04-fc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net504", auto_config: false , :mac => "4438390003e6"
      
      # link for fp1 --> chassis04-fc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net179", auto_config: false , :mac => "443839000162"
      
      # link for fp2 --> chassis04-fc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net375", auto_config: false , :mac => "4438390002e7"
      
      # link for fp3 --> chassis04-fc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net398", auto_config: false , :mac => "443839000315"
      
      # link for fp4 --> chassis04-fc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net235", auto_config: false , :mac => "4438390001d2"
      
      # link for fp5 --> chassis04-fc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net223", auto_config: false , :mac => "4438390001ba"
      
      # link for fp6 --> chassis04-fc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net197", auto_config: false , :mac => "443839000186"
      
      # link for fp7 --> chassis04-fc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net178", auto_config: false , :mac => "443839000160"
      
      # link for fp8 --> chassis04-fc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net152", auto_config: false , :mac => "44383900012c"
      
      # link for fp9 --> chassis04-fc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net482", auto_config: false , :mac => "4438390003bb"
      
      # link for fp10 --> chassis04-fc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net401", auto_config: false , :mac => "44383900031b"
      
      # link for fp11 --> chassis04-fc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net174", auto_config: false , :mac => "443839000158"
      
      # link for fp12 --> chassis04-fc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net97", auto_config: false , :mac => "4438390000be"
      
      # link for fp13 --> chassis04-fc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net73", auto_config: false , :mac => "44383900008f"
      
      # link for fp14 --> chassis04-fc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net198", auto_config: false , :mac => "443839000188"
      
      # link for fp15 --> chassis04-fc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net31", auto_config: false , :mac => "44383900003c"
      
      # link for swp3 --> leaf03:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net497", auto_config: false , :mac => "4438390003da"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:55 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:55", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e6 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e6", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:62 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:62", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e7 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e7", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:15 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:15", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d2 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d2", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ba --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ba", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:86 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:86", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:60 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:60", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2c --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2c", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:bb --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:bb", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1b --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1b", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:58 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:58", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:be --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:be", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8f --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8f", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:88 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:88", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3c --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3c", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:da --> swp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:da", NAME="swp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc2-1 #####
  config.vm.define "chassis03-lc2-1" do |device|
    
    device.vm.hostname = "chassis03-lc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net569", auto_config: false , :mac => "443839000456"
      
      # link for fp0 --> chassis03-fc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net249", auto_config: false , :mac => "4438390001ee"
      
      # link for fp1 --> chassis03-fc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net520", auto_config: false , :mac => "443839000405"
      
      # link for fp2 --> chassis03-fc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net503", auto_config: false , :mac => "4438390003e4"
      
      # link for fp3 --> chassis03-fc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net181", auto_config: false , :mac => "443839000166"
      
      # link for fp4 --> chassis03-fc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net524", auto_config: false , :mac => "44383900040d"
      
      # link for fp5 --> chassis03-fc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net89", auto_config: false , :mac => "4438390000ae"
      
      # link for fp6 --> chassis03-fc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net5", auto_config: false , :mac => "443839000009"
      
      # link for fp7 --> chassis03-fc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net205", auto_config: false , :mac => "443839000196"
      
      # link for fp8 --> chassis03-fc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net374", auto_config: false , :mac => "4438390002e5"
      
      # link for fp9 --> chassis03-fc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net440", auto_config: false , :mac => "443839000367"
      
      # link for fp10 --> chassis03-fc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net362", auto_config: false , :mac => "4438390002cd"
      
      # link for fp11 --> chassis03-fc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net51", auto_config: false , :mac => "443839000063"
      
      # link for fp12 --> chassis03-fc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net228", auto_config: false , :mac => "4438390001c4"
      
      # link for fp13 --> chassis03-fc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net94", auto_config: false , :mac => "4438390000b8"
      
      # link for fp14 --> chassis03-fc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net470", auto_config: false , :mac => "4438390003a3"
      
      # link for fp15 --> chassis03-fc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net454", auto_config: false , :mac => "443839000383"
      
      # link for swp3 --> leaf03:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net284", auto_config: false , :mac => "443839000234"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:56 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:56", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ee --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ee", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:05 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:05", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e4 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e4", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:66 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:66", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0d --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0d", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ae --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ae", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:09 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:09", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:96 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:96", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e5 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e5", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:67 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:67", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:cd --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:cd", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:63 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:63", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c4 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c4", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b8 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b8", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a3 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a3", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:83 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:83", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:34 --> swp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:34", NAME="swp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-fc4-1 #####
  config.vm.define "chassis01-fc4-1" do |device|
    
    device.vm.hostname = "chassis01-fc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-fc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net570", auto_config: false , :mac => "443839000457"
      
      # link for fp0 --> chassis01-lc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net96", auto_config: false , :mac => "4438390000bd"
      
      # link for fp1 --> chassis01-lc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net508", auto_config: false , :mac => "4438390003ee"
      
      # link for fp2 --> chassis01-lc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net378", auto_config: false , :mac => "4438390002ee"
      
      # link for fp3 --> chassis01-lc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net78", auto_config: false , :mac => "44383900009a"
      
      # link for fp4 --> chassis01-lc1-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net341", auto_config: false , :mac => "4438390002a4"
      
      # link for fp5 --> chassis01-lc1-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net412", auto_config: false , :mac => "443839000332"
      
      # link for fp6 --> chassis01-lc1-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net165", auto_config: false , :mac => "443839000147"
      
      # link for fp7 --> chassis01-lc1-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net522", auto_config: false , :mac => "44383900040a"
      
      # link for fp8 --> chassis01-lc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net253", auto_config: false , :mac => "4438390001f7"
      
      # link for fp9 --> chassis01-lc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net456", auto_config: false , :mac => "443839000388"
      
      # link for fp10 --> chassis01-lc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net39", auto_config: false , :mac => "44383900004d"
      
      # link for fp11 --> chassis01-lc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net114", auto_config: false , :mac => "4438390000e1"
      
      # link for fp12 --> chassis01-lc2-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net484", auto_config: false , :mac => "4438390003c0"
      
      # link for fp13 --> chassis01-lc2-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net168", auto_config: false , :mac => "44383900014d"
      
      # link for fp14 --> chassis01-lc2-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net493", auto_config: false , :mac => "4438390003d2"
      
      # link for fp15 --> chassis01-lc2-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net196", auto_config: false , :mac => "443839000185"
      
      # link for fp16 --> chassis01-lc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net349", auto_config: false , :mac => "4438390002b4"
      
      # link for fp17 --> chassis01-lc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net129", auto_config: false , :mac => "4438390000ff"
      
      # link for fp18 --> chassis01-lc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net2", auto_config: false , :mac => "443839000004"
      
      # link for fp19 --> chassis01-lc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net540", auto_config: false , :mac => "44383900042d"
      
      # link for fp20 --> chassis01-lc3-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net381", auto_config: false , :mac => "4438390002f4"
      
      # link for fp21 --> chassis01-lc3-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net386", auto_config: false , :mac => "4438390002fe"
      
      # link for fp22 --> chassis01-lc3-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net139", auto_config: false , :mac => "443839000113"
      
      # link for fp23 --> chassis01-lc3-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net298", auto_config: false , :mac => "443839000250"
      
      # link for fp24 --> chassis01-lc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net474", auto_config: false , :mac => "4438390003ac"
      
      # link for fp25 --> chassis01-lc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net146", auto_config: false , :mac => "443839000121"
      
      # link for fp26 --> chassis01-lc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net226", auto_config: false , :mac => "4438390001c1"
      
      # link for fp27 --> chassis01-lc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net185", auto_config: false , :mac => "44383900016f"
      
      # link for fp28 --> chassis01-lc4-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net25", auto_config: false , :mac => "443839000032"
      
      # link for fp29 --> chassis01-lc4-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net477", auto_config: false , :mac => "4438390003b2"
      
      # link for fp30 --> chassis01-lc4-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net8", auto_config: false , :mac => "443839000010"
      
      # link for fp31 --> chassis01-lc4-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net321", auto_config: false , :mac => "44383900027c"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:57 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:57", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:bd --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:bd", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ee --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ee", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ee --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ee", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9a --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9a", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a4 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a4", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:32 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:32", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:47 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:47", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f7 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f7", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:88 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:88", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4d --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4d", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e1 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e1", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c0 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c0", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4d --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4d", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d2 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d2", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:85 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:85", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b4 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b4", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ff --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ff", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:04 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:04", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2d --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2d", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f4 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f4", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:fe --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:fe", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:13 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:13", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:50 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:50", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ac --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ac", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:21 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:21", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c1 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c1", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6f --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6f", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:32 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:32", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b2 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b2", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:10 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:10", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7c --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7c", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-fc1-1 #####
  config.vm.define "chassis01-fc1-1" do |device|
    
    device.vm.hostname = "chassis01-fc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-fc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net571", auto_config: false , :mac => "443839000458"
      
      # link for fp0 --> chassis01-lc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net254", auto_config: false , :mac => "4438390001f9"
      
      # link for fp1 --> chassis01-lc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net509", auto_config: false , :mac => "4438390003f0"
      
      # link for fp2 --> chassis01-lc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net434", auto_config: false , :mac => "44383900035d"
      
      # link for fp3 --> chassis01-lc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net182", auto_config: false , :mac => "443839000169"
      
      # link for fp4 --> chassis01-lc1-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net495", auto_config: false , :mac => "4438390003d6"
      
      # link for fp5 --> chassis01-lc1-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net302", auto_config: false , :mac => "443839000258"
      
      # link for fp6 --> chassis01-lc1-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net23", auto_config: false , :mac => "44383900002e"
      
      # link for fp7 --> chassis01-lc1-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net420", auto_config: false , :mac => "443839000341"
      
      # link for fp8 --> chassis01-lc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net318", auto_config: false , :mac => "443839000276"
      
      # link for fp9 --> chassis01-lc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net317", auto_config: false , :mac => "443839000274"
      
      # link for fp10 --> chassis01-lc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net360", auto_config: false , :mac => "4438390002ca"
      
      # link for fp11 --> chassis01-lc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net295", auto_config: false , :mac => "44383900024a"
      
      # link for fp12 --> chassis01-lc2-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net486", auto_config: false , :mac => "4438390003c4"
      
      # link for fp13 --> chassis01-lc2-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net390", auto_config: false , :mac => "443839000306"
      
      # link for fp14 --> chassis01-lc2-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net110", auto_config: false , :mac => "4438390000d9"
      
      # link for fp15 --> chassis01-lc2-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net402", auto_config: false , :mac => "44383900031e"
      
      # link for fp16 --> chassis01-lc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net437", auto_config: false , :mac => "443839000362"
      
      # link for fp17 --> chassis01-lc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net125", auto_config: false , :mac => "4438390000f7"
      
      # link for fp18 --> chassis01-lc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net494", auto_config: false , :mac => "4438390003d4"
      
      # link for fp19 --> chassis01-lc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net426", auto_config: false , :mac => "44383900034d"
      
      # link for fp20 --> chassis01-lc3-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net471", auto_config: false , :mac => "4438390003a6"
      
      # link for fp21 --> chassis01-lc3-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net372", auto_config: false , :mac => "4438390002e2"
      
      # link for fp22 --> chassis01-lc3-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net313", auto_config: false , :mac => "44383900026d"
      
      # link for fp23 --> chassis01-lc3-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net37", auto_config: false , :mac => "443839000049"
      
      # link for fp24 --> chassis01-lc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net42", auto_config: false , :mac => "443839000052"
      
      # link for fp25 --> chassis01-lc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net534", auto_config: false , :mac => "443839000421"
      
      # link for fp26 --> chassis01-lc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net151", auto_config: false , :mac => "44383900012b"
      
      # link for fp27 --> chassis01-lc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net465", auto_config: false , :mac => "44383900039a"
      
      # link for fp28 --> chassis01-lc4-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net337", auto_config: false , :mac => "44383900029c"
      
      # link for fp29 --> chassis01-lc4-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net446", auto_config: false , :mac => "443839000374"
      
      # link for fp30 --> chassis01-lc4-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net3", auto_config: false , :mac => "443839000006"
      
      # link for fp31 --> chassis01-lc4-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net438", auto_config: false , :mac => "443839000364"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:58 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:58", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f9 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f9", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f0 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f0", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5d --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5d", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:69 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:69", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d6 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d6", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:58 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:58", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2e --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2e", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:41 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:41", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:76 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:76", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:74 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:74", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ca --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ca", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4a --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4a", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c4 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c4", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:06 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:06", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d9 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d9", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1e --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1e", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:62 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:62", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f7 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f7", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d4 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d4", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4d --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4d", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a6 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a6", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e2 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e2", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6d --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6d", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:49 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:49", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:52 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:52", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:21 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:21", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2b --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2b", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9a --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9a", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9c --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9c", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:74 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:74", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:06 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:06", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:64 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:64", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc3-1 #####
  config.vm.define "chassis02-lc3-1" do |device|
    
    device.vm.hostname = "chassis02-lc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net572", auto_config: false , :mac => "443839000459"
      
      # link for fp0 --> chassis02-fc1-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net488", auto_config: false , :mac => "4438390003c7"
      
      # link for fp1 --> chassis02-fc1-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net400", auto_config: false , :mac => "443839000319"
      
      # link for fp2 --> chassis02-fc1-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net448", auto_config: false , :mac => "443839000377"
      
      # link for fp3 --> chassis02-fc1-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net66", auto_config: false , :mac => "443839000081"
      
      # link for fp4 --> chassis02-fc2-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net395", auto_config: false , :mac => "44383900030f"
      
      # link for fp5 --> chassis02-fc2-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net206", auto_config: false , :mac => "443839000198"
      
      # link for fp6 --> chassis02-fc2-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net319", auto_config: false , :mac => "443839000277"
      
      # link for fp7 --> chassis02-fc2-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net47", auto_config: false , :mac => "44383900005b"
      
      # link for fp8 --> chassis02-fc3-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net54", auto_config: false , :mac => "443839000069"
      
      # link for fp9 --> chassis02-fc3-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net288", auto_config: false , :mac => "44383900023b"
      
      # link for fp10 --> chassis02-fc3-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net332", auto_config: false , :mac => "443839000291"
      
      # link for fp11 --> chassis02-fc3-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net510", auto_config: false , :mac => "4438390003f1"
      
      # link for fp12 --> chassis02-fc4-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net61", auto_config: false , :mac => "443839000077"
      
      # link for fp13 --> chassis02-fc4-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net134", auto_config: false , :mac => "443839000108"
      
      # link for fp14 --> chassis02-fc4-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net103", auto_config: false , :mac => "4438390000ca"
      
      # link for fp15 --> chassis02-fc4-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net394", auto_config: false , :mac => "44383900030d"
      
      # link for swp5 --> leaf05:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net496", auto_config: false , :mac => "4438390003d8"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:59 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:59", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c7 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c7", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:19 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:19", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:77 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:77", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:81 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:81", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0f --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0f", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:98 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:98", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:77 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:77", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5b --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5b", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:69 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:69", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3b --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3b", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:91 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:91", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f1 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f1", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:77 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:77", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:08 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:08", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ca --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ca", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0d --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0d", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d8 --> swp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d8", NAME="swp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc3-2 #####
  config.vm.define "chassis04-lc3-2" do |device|
    
    device.vm.hostname = "chassis04-lc3-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc3-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net573", auto_config: false , :mac => "44383900045a"
      
      # link for fp0 --> chassis04-fc1-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net364", auto_config: false , :mac => "4438390002d1"
      
      # link for fp1 --> chassis04-fc1-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net343", auto_config: false , :mac => "4438390002a7"
      
      # link for fp2 --> chassis04-fc1-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net291", auto_config: false , :mac => "443839000241"
      
      # link for fp3 --> chassis04-fc1-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net452", auto_config: false , :mac => "44383900037f"
      
      # link for fp4 --> chassis04-fc2-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net365", auto_config: false , :mac => "4438390002d3"
      
      # link for fp5 --> chassis04-fc2-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net236", auto_config: false , :mac => "4438390001d4"
      
      # link for fp6 --> chassis04-fc2-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net518", auto_config: false , :mac => "443839000401"
      
      # link for fp7 --> chassis04-fc2-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net370", auto_config: false , :mac => "4438390002dd"
      
      # link for fp8 --> chassis04-fc3-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net355", auto_config: false , :mac => "4438390002bf"
      
      # link for fp9 --> chassis04-fc3-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net266", auto_config: false , :mac => "443839000210"
      
      # link for fp10 --> chassis04-fc3-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net210", auto_config: false , :mac => "4438390001a0"
      
      # link for fp11 --> chassis04-fc3-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net283", auto_config: false , :mac => "443839000231"
      
      # link for fp12 --> chassis04-fc4-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net345", auto_config: false , :mac => "4438390002ab"
      
      # link for fp13 --> chassis04-fc4-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net16", auto_config: false , :mac => "44383900001f"
      
      # link for fp14 --> chassis04-fc4-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net173", auto_config: false , :mac => "443839000156"
      
      # link for fp15 --> chassis04-fc4-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net551", auto_config: false , :mac => "443839000442"
      
      # link for swp6 --> leaf06:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net449", auto_config: false , :mac => "44383900037a"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5a --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5a", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d1 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d1", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a7 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a7", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:41 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:41", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7f --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7f", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d3 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d3", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d4 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d4", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:01 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:01", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:dd --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:dd", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:bf --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:bf", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:10 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:10", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a0 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a0", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:31 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:31", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ab --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ab", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1f --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1f", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:56 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:56", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:42 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:42", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7a --> swp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7a", NAME="swp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc1-2 #####
  config.vm.define "chassis03-lc1-2" do |device|
    
    device.vm.hostname = "chassis03-lc1-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc1-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net574", auto_config: false , :mac => "44383900045b"
      
      # link for fp0 --> chassis03-fc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net282", auto_config: false , :mac => "44383900022f"
      
      # link for fp1 --> chassis03-fc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net326", auto_config: false , :mac => "443839000285"
      
      # link for fp2 --> chassis03-fc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net212", auto_config: false , :mac => "4438390001a4"
      
      # link for fp3 --> chassis03-fc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net4", auto_config: false , :mac => "443839000007"
      
      # link for fp4 --> chassis03-fc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net113", auto_config: false , :mac => "4438390000de"
      
      # link for fp5 --> chassis03-fc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net458", auto_config: false , :mac => "44383900038b"
      
      # link for fp6 --> chassis03-fc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net20", auto_config: false , :mac => "443839000027"
      
      # link for fp7 --> chassis03-fc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net414", auto_config: false , :mac => "443839000335"
      
      # link for fp8 --> chassis03-fc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net366", auto_config: false , :mac => "4438390002d5"
      
      # link for fp9 --> chassis03-fc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net502", auto_config: false , :mac => "4438390003e2"
      
      # link for fp10 --> chassis03-fc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net528", auto_config: false , :mac => "443839000415"
      
      # link for fp11 --> chassis03-fc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net389", auto_config: false , :mac => "443839000303"
      
      # link for fp12 --> chassis03-fc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net259", auto_config: false , :mac => "443839000202"
      
      # link for fp13 --> chassis03-fc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net320", auto_config: false , :mac => "443839000279"
      
      # link for fp14 --> chassis03-fc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net285", auto_config: false , :mac => "443839000235"
      
      # link for fp15 --> chassis03-fc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net101", auto_config: false , :mac => "4438390000c6"
      
      # link for swp2 --> leaf02:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net314", auto_config: false , :mac => "44383900026f"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5b --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5b", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2f --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2f", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:85 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:85", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a4 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a4", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:07 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:07", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:de --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:de", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8b --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8b", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:27 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:27", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:35 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:35", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d5 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d5", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e2 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e2", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:15 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:15", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:03 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:03", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:02 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:02", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:79 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:79", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:35 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:35", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c6 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c6", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6f --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6f", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-fc3-1 #####
  config.vm.define "chassis01-fc3-1" do |device|
    
    device.vm.hostname = "chassis01-fc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-fc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net575", auto_config: false , :mac => "44383900045c"
      
      # link for fp0 --> chassis01-lc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net421", auto_config: false , :mac => "443839000343"
      
      # link for fp1 --> chassis01-lc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net533", auto_config: false , :mac => "44383900041f"
      
      # link for fp2 --> chassis01-lc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net393", auto_config: false , :mac => "44383900030c"
      
      # link for fp3 --> chassis01-lc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net507", auto_config: false , :mac => "4438390003ec"
      
      # link for fp4 --> chassis01-lc1-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net80", auto_config: false , :mac => "44383900009e"
      
      # link for fp5 --> chassis01-lc1-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net230", auto_config: false , :mac => "4438390001c9"
      
      # link for fp6 --> chassis01-lc1-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net176", auto_config: false , :mac => "44383900015d"
      
      # link for fp7 --> chassis01-lc1-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net207", auto_config: false , :mac => "44383900019b"
      
      # link for fp8 --> chassis01-lc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net1", auto_config: false , :mac => "443839000002"
      
      # link for fp9 --> chassis01-lc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net467", auto_config: false , :mac => "44383900039e"
      
      # link for fp10 --> chassis01-lc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net232", auto_config: false , :mac => "4438390001cd"
      
      # link for fp11 --> chassis01-lc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net432", auto_config: false , :mac => "443839000359"
      
      # link for fp12 --> chassis01-lc2-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net247", auto_config: false , :mac => "4438390001eb"
      
      # link for fp13 --> chassis01-lc2-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net13", auto_config: false , :mac => "44383900001a"
      
      # link for fp14 --> chassis01-lc2-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net32", auto_config: false , :mac => "44383900003f"
      
      # link for fp15 --> chassis01-lc2-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net450", auto_config: false , :mac => "44383900037c"
      
      # link for fp16 --> chassis01-lc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net24", auto_config: false , :mac => "443839000030"
      
      # link for fp17 --> chassis01-lc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net30", auto_config: false , :mac => "44383900003b"
      
      # link for fp18 --> chassis01-lc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net445", auto_config: false , :mac => "443839000372"
      
      # link for fp19 --> chassis01-lc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net339", auto_config: false , :mac => "4438390002a0"
      
      # link for fp20 --> chassis01-lc3-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net188", auto_config: false , :mac => "443839000175"
      
      # link for fp21 --> chassis01-lc3-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net315", auto_config: false , :mac => "443839000271"
      
      # link for fp22 --> chassis01-lc3-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net328", auto_config: false , :mac => "44383900028a"
      
      # link for fp23 --> chassis01-lc3-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net243", auto_config: false , :mac => "4438390001e3"
      
      # link for fp24 --> chassis01-lc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net122", auto_config: false , :mac => "4438390000f1"
      
      # link for fp25 --> chassis01-lc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net133", auto_config: false , :mac => "443839000107"
      
      # link for fp26 --> chassis01-lc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net233", auto_config: false , :mac => "4438390001cf"
      
      # link for fp27 --> chassis01-lc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net256", auto_config: false , :mac => "4438390001fd"
      
      # link for fp28 --> chassis01-lc4-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net163", auto_config: false , :mac => "443839000143"
      
      # link for fp29 --> chassis01-lc4-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net169", auto_config: false , :mac => "44383900014f"
      
      # link for fp30 --> chassis01-lc4-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net106", auto_config: false , :mac => "4438390000d1"
      
      # link for fp31 --> chassis01-lc4-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net273", auto_config: false , :mac => "44383900021f"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5c --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5c", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:43 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:43", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1f --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1f", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0c --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0c", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ec --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ec", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9e --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9e", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c9 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c9", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5d --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5d", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9b --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9b", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:02 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:02", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:cd --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:cd", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:59 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:59", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:eb --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:eb", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1a --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1a", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3f --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3f", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7c --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7c", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:30 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:30", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3b --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3b", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:72 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:72", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a0 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a0", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:75 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:75", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:71 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:71", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8a --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8a", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e3 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e3", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f1 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f1", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:07 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:07", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:cf --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:cf", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:fd --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:fd", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:43 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:43", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4f --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4f", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d1 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d1", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1f --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1f", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc4-1 #####
  config.vm.define "chassis02-lc4-1" do |device|
    
    device.vm.hostname = "chassis02-lc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net576", auto_config: false , :mac => "44383900045d"
      
      # link for fp0 --> chassis02-fc1-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net63", auto_config: false , :mac => "44383900007b"
      
      # link for fp1 --> chassis02-fc1-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net43", auto_config: false , :mac => "443839000053"
      
      # link for fp2 --> chassis02-fc1-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net279", auto_config: false , :mac => "443839000229"
      
      # link for fp3 --> chassis02-fc1-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net336", auto_config: false , :mac => "443839000299"
      
      # link for fp4 --> chassis02-fc2-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net361", auto_config: false , :mac => "4438390002cb"
      
      # link for fp5 --> chassis02-fc2-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net248", auto_config: false , :mac => "4438390001ec"
      
      # link for fp6 --> chassis02-fc2-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net325", auto_config: false , :mac => "443839000283"
      
      # link for fp7 --> chassis02-fc2-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net91", auto_config: false , :mac => "4438390000b2"
      
      # link for fp8 --> chassis02-fc3-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net430", auto_config: false , :mac => "443839000354"
      
      # link for fp9 --> chassis02-fc3-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net505", auto_config: false , :mac => "4438390003e8"
      
      # link for fp10 --> chassis02-fc3-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net466", auto_config: false , :mac => "44383900039b"
      
      # link for fp11 --> chassis02-fc3-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net479", auto_config: false , :mac => "4438390003b5"
      
      # link for fp12 --> chassis02-fc4-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net258", auto_config: false , :mac => "443839000200"
      
      # link for fp13 --> chassis02-fc4-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net451", auto_config: false , :mac => "44383900037d"
      
      # link for fp14 --> chassis02-fc4-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net289", auto_config: false , :mac => "44383900023d"
      
      # link for fp15 --> chassis02-fc4-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net44", auto_config: false , :mac => "443839000055"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5d --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5d", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7b --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7b", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:53 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:53", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:29 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:29", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:99 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:99", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:cb --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:cb", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ec --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ec", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:83 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:83", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b2 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b2", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:54 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:54", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e8 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e8", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9b --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9b", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b5 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b5", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:00 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:00", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7d --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7d", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3d --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3d", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:55 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:55", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc4-2 #####
  config.vm.define "chassis02-lc4-2" do |device|
    
    device.vm.hostname = "chassis02-lc4-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc4-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net577", auto_config: false , :mac => "44383900045e"
      
      # link for fp0 --> chassis02-fc1-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net261", auto_config: false , :mac => "443839000206"
      
      # link for fp1 --> chassis02-fc1-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net112", auto_config: false , :mac => "4438390000dc"
      
      # link for fp2 --> chassis02-fc1-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net121", auto_config: false , :mac => "4438390000ee"
      
      # link for fp3 --> chassis02-fc1-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net145", auto_config: false , :mac => "44383900011e"
      
      # link for fp4 --> chassis02-fc2-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net88", auto_config: false , :mac => "4438390000ac"
      
      # link for fp5 --> chassis02-fc2-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net455", auto_config: false , :mac => "443839000385"
      
      # link for fp6 --> chassis02-fc2-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net85", auto_config: false , :mac => "4438390000a7"
      
      # link for fp7 --> chassis02-fc2-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net175", auto_config: false , :mac => "44383900015a"
      
      # link for fp8 --> chassis02-fc3-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net363", auto_config: false , :mac => "4438390002cf"
      
      # link for fp9 --> chassis02-fc3-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net203", auto_config: false , :mac => "443839000192"
      
      # link for fp10 --> chassis02-fc3-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net419", auto_config: false , :mac => "44383900033e"
      
      # link for fp11 --> chassis02-fc3-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net157", auto_config: false , :mac => "443839000136"
      
      # link for fp12 --> chassis02-fc4-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net195", auto_config: false , :mac => "443839000182"
      
      # link for fp13 --> chassis02-fc4-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net391", auto_config: false , :mac => "443839000307"
      
      # link for fp14 --> chassis02-fc4-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net418", auto_config: false , :mac => "44383900033c"
      
      # link for fp15 --> chassis02-fc4-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net164", auto_config: false , :mac => "443839000144"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5e --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5e", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:06 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:06", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:dc --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:dc", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ee --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ee", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1e --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1e", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ac --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ac", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:85 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:85", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a7 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a7", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:cf --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:cf", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:92 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:92", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3e --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3e", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:36 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:36", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:82 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:82", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:07 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:07", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3c --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3c", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:44 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:44", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc3-2 #####
  config.vm.define "chassis03-lc3-2" do |device|
    
    device.vm.hostname = "chassis03-lc3-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc3-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net578", auto_config: false , :mac => "44383900045f"
      
      # link for fp0 --> chassis03-fc1-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net369", auto_config: false , :mac => "4438390002db"
      
      # link for fp1 --> chassis03-fc1-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net442", auto_config: false , :mac => "44383900036b"
      
      # link for fp2 --> chassis03-fc1-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net209", auto_config: false , :mac => "44383900019e"
      
      # link for fp3 --> chassis03-fc1-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net62", auto_config: false , :mac => "443839000079"
      
      # link for fp4 --> chassis03-fc2-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net108", auto_config: false , :mac => "4438390000d4"
      
      # link for fp5 --> chassis03-fc2-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net308", auto_config: false , :mac => "443839000262"
      
      # link for fp6 --> chassis03-fc2-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net333", auto_config: false , :mac => "443839000293"
      
      # link for fp7 --> chassis03-fc2-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net238", auto_config: false , :mac => "4438390001d8"
      
      # link for fp8 --> chassis03-fc3-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net424", auto_config: false , :mac => "443839000348"
      
      # link for fp9 --> chassis03-fc3-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net307", auto_config: false , :mac => "443839000260"
      
      # link for fp10 --> chassis03-fc3-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net244", auto_config: false , :mac => "4438390001e4"
      
      # link for fp11 --> chassis03-fc3-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net306", auto_config: false , :mac => "44383900025e"
      
      # link for fp12 --> chassis03-fc4-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net98", auto_config: false , :mac => "4438390000c0"
      
      # link for fp13 --> chassis03-fc4-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net180", auto_config: false , :mac => "443839000164"
      
      # link for fp14 --> chassis03-fc4-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net483", auto_config: false , :mac => "4438390003bd"
      
      # link for fp15 --> chassis03-fc4-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net17", auto_config: false , :mac => "443839000021"
      
      # link for swp6 --> leaf06:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net511", auto_config: false , :mac => "4438390003f4"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:5f --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:5f", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:db --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:db", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6b --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6b", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9e --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9e", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:79 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:79", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d4 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d4", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:62 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:62", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:93 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:93", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d8 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d8", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:48 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:48", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:60 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:60", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e4 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e4", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5e --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5e", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c0 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c0", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:64 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:64", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:bd --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:bd", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:21 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:21", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f4 --> swp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f4", NAME="swp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-fc3-1 #####
  config.vm.define "chassis04-fc3-1" do |device|
    
    device.vm.hostname = "chassis04-fc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-fc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net579", auto_config: false , :mac => "443839000460"
      
      # link for fp0 --> chassis04-lc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net519", auto_config: false , :mac => "443839000404"
      
      # link for fp1 --> chassis04-lc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net541", auto_config: false , :mac => "44383900042f"
      
      # link for fp2 --> chassis04-lc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net297", auto_config: false , :mac => "44383900024e"
      
      # link for fp3 --> chassis04-lc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net219", auto_config: false , :mac => "4438390001b3"
      
      # link for fp4 --> chassis04-lc1-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net411", auto_config: false , :mac => "443839000330"
      
      # link for fp5 --> chassis04-lc1-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net553", auto_config: false , :mac => "443839000446"
      
      # link for fp6 --> chassis04-lc1-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net162", auto_config: false , :mac => "443839000141"
      
      # link for fp7 --> chassis04-lc1-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net457", auto_config: false , :mac => "44383900038a"
      
      # link for fp8 --> chassis04-lc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net152", auto_config: false , :mac => "44383900012d"
      
      # link for fp9 --> chassis04-lc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net482", auto_config: false , :mac => "4438390003bc"
      
      # link for fp10 --> chassis04-lc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net401", auto_config: false , :mac => "44383900031c"
      
      # link for fp11 --> chassis04-lc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net174", auto_config: false , :mac => "443839000159"
      
      # link for fp12 --> chassis04-lc2-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net22", auto_config: false , :mac => "44383900002c"
      
      # link for fp13 --> chassis04-lc2-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net347", auto_config: false , :mac => "4438390002b0"
      
      # link for fp14 --> chassis04-lc2-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net184", auto_config: false , :mac => "44383900016d"
      
      # link for fp15 --> chassis04-lc2-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net84", auto_config: false , :mac => "4438390000a6"
      
      # link for fp16 --> chassis04-lc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net459", auto_config: false , :mac => "44383900038e"
      
      # link for fp17 --> chassis04-lc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net240", auto_config: false , :mac => "4438390001dd"
      
      # link for fp18 --> chassis04-lc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net492", auto_config: false , :mac => "4438390003d0"
      
      # link for fp19 --> chassis04-lc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net36", auto_config: false , :mac => "443839000047"
      
      # link for fp20 --> chassis04-lc3-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net355", auto_config: false , :mac => "4438390002c0"
      
      # link for fp21 --> chassis04-lc3-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net266", auto_config: false , :mac => "443839000211"
      
      # link for fp22 --> chassis04-lc3-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net210", auto_config: false , :mac => "4438390001a1"
      
      # link for fp23 --> chassis04-lc3-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net283", auto_config: false , :mac => "443839000232"
      
      # link for fp24 --> chassis04-lc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net300", auto_config: false , :mac => "443839000254"
      
      # link for fp25 --> chassis04-lc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net270", auto_config: false , :mac => "443839000219"
      
      # link for fp26 --> chassis04-lc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net501", auto_config: false , :mac => "4438390003e1"
      
      # link for fp27 --> chassis04-lc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net120", auto_config: false , :mac => "4438390000ed"
      
      # link for fp28 --> chassis04-lc4-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net11", auto_config: false , :mac => "443839000016"
      
      # link for fp29 --> chassis04-lc4-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net344", auto_config: false , :mac => "4438390002aa"
      
      # link for fp30 --> chassis04-lc4-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net543", auto_config: false , :mac => "443839000433"
      
      # link for fp31 --> chassis04-lc4-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net214", auto_config: false , :mac => "4438390001a9"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:60 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:60", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:04 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:04", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2f --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2f", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4e --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4e", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b3 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b3", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:30 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:30", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:46 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:46", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:41 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:41", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2d --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2d", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:bc --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:bc", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1c --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1c", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:59 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:59", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2c --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2c", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b0 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b0", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6d --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6d", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a6 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a6", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8e --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8e", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:dd --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:dd", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d0 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d0", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:47 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:47", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c0 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c0", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:11 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:11", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a1 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a1", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:32 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:32", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:54 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:54", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:19 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:19", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e1 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e1", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ed --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ed", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:16 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:16", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:aa --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:aa", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:33 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:33", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a9 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a9", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc2-2 #####
  config.vm.define "chassis04-lc2-2" do |device|
    
    device.vm.hostname = "chassis04-lc2-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc2-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net580", auto_config: false , :mac => "443839000461"
      
      # link for fp0 --> chassis04-fc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net514", auto_config: false , :mac => "4438390003f9"
      
      # link for fp1 --> chassis04-fc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net324", auto_config: false , :mac => "443839000281"
      
      # link for fp2 --> chassis04-fc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net521", auto_config: false , :mac => "443839000407"
      
      # link for fp3 --> chassis04-fc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net491", auto_config: false , :mac => "4438390003cd"
      
      # link for fp4 --> chassis04-fc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net357", auto_config: false , :mac => "4438390002c3"
      
      # link for fp5 --> chassis04-fc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net246", auto_config: false , :mac => "4438390001e8"
      
      # link for fp6 --> chassis04-fc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net186", auto_config: false , :mac => "443839000170"
      
      # link for fp7 --> chassis04-fc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net100", auto_config: false , :mac => "4438390000c4"
      
      # link for fp8 --> chassis04-fc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net22", auto_config: false , :mac => "44383900002b"
      
      # link for fp9 --> chassis04-fc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net347", auto_config: false , :mac => "4438390002af"
      
      # link for fp10 --> chassis04-fc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net184", auto_config: false , :mac => "44383900016c"
      
      # link for fp11 --> chassis04-fc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net84", auto_config: false , :mac => "4438390000a5"
      
      # link for fp12 --> chassis04-fc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net523", auto_config: false , :mac => "44383900040b"
      
      # link for fp13 --> chassis04-fc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net516", auto_config: false , :mac => "4438390003fd"
      
      # link for fp14 --> chassis04-fc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net189", auto_config: false , :mac => "443839000176"
      
      # link for fp15 --> chassis04-fc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net358", auto_config: false , :mac => "4438390002c5"
      
      # link for swp4 --> leaf04:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net309", auto_config: false , :mac => "443839000265"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:61 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:61", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f9 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f9", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:81 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:81", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:07 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:07", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:cd --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:cd", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c3 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c3", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e8 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e8", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:70 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:70", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c4 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c4", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2b --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2b", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:af --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:af", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6c --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6c", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a5 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a5", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0b --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0b", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:fd --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:fd", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:76 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:76", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c5 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c5", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:65 --> swp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:65", NAME="swp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-fc2-1 #####
  config.vm.define "chassis01-fc2-1" do |device|
    
    device.vm.hostname = "chassis01-fc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-fc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net581", auto_config: false , :mac => "443839000462"
      
      # link for fp0 --> chassis01-lc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net476", auto_config: false , :mac => "4438390003b0"
      
      # link for fp1 --> chassis01-lc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net268", auto_config: false , :mac => "443839000215"
      
      # link for fp2 --> chassis01-lc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net311", auto_config: false , :mac => "443839000269"
      
      # link for fp3 --> chassis01-lc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net278", auto_config: false , :mac => "443839000228"
      
      # link for fp4 --> chassis01-lc1-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net544", auto_config: false , :mac => "443839000435"
      
      # link for fp5 --> chassis01-lc1-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net517", auto_config: false , :mac => "443839000400"
      
      # link for fp6 --> chassis01-lc1-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net116", auto_config: false , :mac => "4438390000e5"
      
      # link for fp7 --> chassis01-lc1-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net292", auto_config: false , :mac => "443839000244"
      
      # link for fp8 --> chassis01-lc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net264", auto_config: false , :mac => "44383900020d"
      
      # link for fp9 --> chassis01-lc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net7", auto_config: false , :mac => "44383900000e"
      
      # link for fp10 --> chassis01-lc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net342", auto_config: false , :mac => "4438390002a6"
      
      # link for fp11 --> chassis01-lc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net431", auto_config: false , :mac => "443839000357"
      
      # link for fp12 --> chassis01-lc2-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net242", auto_config: false , :mac => "4438390001e1"
      
      # link for fp13 --> chassis01-lc2-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net27", auto_config: false , :mac => "443839000035"
      
      # link for fp14 --> chassis01-lc2-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net211", auto_config: false , :mac => "4438390001a3"
      
      # link for fp15 --> chassis01-lc2-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net428", auto_config: false , :mac => "443839000351"
      
      # link for fp16 --> chassis01-lc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net200", auto_config: false , :mac => "44383900018d"
      
      # link for fp17 --> chassis01-lc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net293", auto_config: false , :mac => "443839000246"
      
      # link for fp18 --> chassis01-lc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net135", auto_config: false , :mac => "44383900010b"
      
      # link for fp19 --> chassis01-lc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net92", auto_config: false , :mac => "4438390000b5"
      
      # link for fp20 --> chassis01-lc3-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net71", auto_config: false , :mac => "44383900008c"
      
      # link for fp21 --> chassis01-lc3-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net404", auto_config: false , :mac => "443839000322"
      
      # link for fp22 --> chassis01-lc3-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net58", auto_config: false , :mac => "443839000072"
      
      # link for fp23 --> chassis01-lc3-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net29", auto_config: false , :mac => "443839000039"
      
      # link for fp24 --> chassis01-lc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net473", auto_config: false , :mac => "4438390003aa"
      
      # link for fp25 --> chassis01-lc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net406", auto_config: false , :mac => "443839000326"
      
      # link for fp26 --> chassis01-lc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net239", auto_config: false , :mac => "4438390001db"
      
      # link for fp27 --> chassis01-lc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net167", auto_config: false , :mac => "44383900014b"
      
      # link for fp28 --> chassis01-lc4-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net427", auto_config: false , :mac => "44383900034f"
      
      # link for fp29 --> chassis01-lc4-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net267", auto_config: false , :mac => "443839000213"
      
      # link for fp30 --> chassis01-lc4-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net388", auto_config: false , :mac => "443839000302"
      
      # link for fp31 --> chassis01-lc4-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net34", auto_config: false , :mac => "443839000043"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:62 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:62", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b0 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b0", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:15 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:15", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:69 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:69", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:28 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:28", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:35 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:35", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:00 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:00", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e5 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e5", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:44 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:44", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0d --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0d", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a6 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a6", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:57 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:57", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e1 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e1", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:35 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:35", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a3 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a3", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:51 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:51", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8d --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8d", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:46 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:46", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0b --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0b", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b5 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b5", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8c --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8c", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:22 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:22", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:72 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:72", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:39 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:39", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:aa --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:aa", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:26 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:26", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:db --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:db", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4b --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4b", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4f --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4f", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:13 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:13", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:02 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:02", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:43 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:43", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-fc2-1 #####
  config.vm.define "chassis04-fc2-1" do |device|
    
    device.vm.hostname = "chassis04-fc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-fc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net582", auto_config: false , :mac => "443839000463"
      
      # link for fp0 --> chassis04-lc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net118", auto_config: false , :mac => "4438390000e9"
      
      # link for fp1 --> chassis04-lc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net171", auto_config: false , :mac => "443839000153"
      
      # link for fp2 --> chassis04-lc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net287", auto_config: false , :mac => "44383900023a"
      
      # link for fp3 --> chassis04-lc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net480", auto_config: false , :mac => "4438390003b8"
      
      # link for fp4 --> chassis04-lc1-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net330", auto_config: false , :mac => "44383900028e"
      
      # link for fp5 --> chassis04-lc1-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net463", auto_config: false , :mac => "443839000396"
      
      # link for fp6 --> chassis04-lc1-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net141", auto_config: false , :mac => "443839000117"
      
      # link for fp7 --> chassis04-lc1-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net170", auto_config: false , :mac => "443839000151"
      
      # link for fp8 --> chassis04-lc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net235", auto_config: false , :mac => "4438390001d3"
      
      # link for fp9 --> chassis04-lc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net223", auto_config: false , :mac => "4438390001bb"
      
      # link for fp10 --> chassis04-lc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net197", auto_config: false , :mac => "443839000187"
      
      # link for fp11 --> chassis04-lc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net178", auto_config: false , :mac => "443839000161"
      
      # link for fp12 --> chassis04-lc2-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net357", auto_config: false , :mac => "4438390002c4"
      
      # link for fp13 --> chassis04-lc2-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net246", auto_config: false , :mac => "4438390001e9"
      
      # link for fp14 --> chassis04-lc2-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net186", auto_config: false , :mac => "443839000171"
      
      # link for fp15 --> chassis04-lc2-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net100", auto_config: false , :mac => "4438390000c5"
      
      # link for fp16 --> chassis04-lc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net161", auto_config: false , :mac => "44383900013f"
      
      # link for fp17 --> chassis04-lc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net436", auto_config: false , :mac => "443839000360"
      
      # link for fp18 --> chassis04-lc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net222", auto_config: false , :mac => "4438390001b9"
      
      # link for fp19 --> chassis04-lc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net72", auto_config: false , :mac => "44383900008e"
      
      # link for fp20 --> chassis04-lc3-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net365", auto_config: false , :mac => "4438390002d4"
      
      # link for fp21 --> chassis04-lc3-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net236", auto_config: false , :mac => "4438390001d5"
      
      # link for fp22 --> chassis04-lc3-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net518", auto_config: false , :mac => "443839000402"
      
      # link for fp23 --> chassis04-lc3-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net370", auto_config: false , :mac => "4438390002de"
      
      # link for fp24 --> chassis04-lc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net229", auto_config: false , :mac => "4438390001c7"
      
      # link for fp25 --> chassis04-lc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net538", auto_config: false , :mac => "443839000429"
      
      # link for fp26 --> chassis04-lc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net487", auto_config: false , :mac => "4438390003c6"
      
      # link for fp27 --> chassis04-lc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net82", auto_config: false , :mac => "4438390000a2"
      
      # link for fp28 --> chassis04-lc4-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net40", auto_config: false , :mac => "44383900004f"
      
      # link for fp29 --> chassis04-lc4-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net429", auto_config: false , :mac => "443839000353"
      
      # link for fp30 --> chassis04-lc4-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net548", auto_config: false , :mac => "44383900043d"
      
      # link for fp31 --> chassis04-lc4-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net527", auto_config: false , :mac => "443839000414"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:63 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:63", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e9 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e9", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:53 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:53", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3a --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3a", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b8 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b8", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8e --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8e", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:96 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:96", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:17 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:17", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:51 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:51", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d3 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d3", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:bb --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:bb", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:87 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:87", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:61 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:61", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c4 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c4", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e9 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e9", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:71 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:71", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c5 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c5", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3f --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3f", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:60 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:60", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b9 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b9", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8e --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8e", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d4 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d4", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d5 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d5", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:02 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:02", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:de --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:de", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c7 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c7", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:29 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:29", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c6 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c6", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a2 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a2", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4f --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4f", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:53 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:53", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3d --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3d", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:14 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:14", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-fc4-1 #####
  config.vm.define "chassis04-fc4-1" do |device|
    
    device.vm.hostname = "chassis04-fc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-fc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net583", auto_config: false , :mac => "443839000464"
      
      # link for fp0 --> chassis04-lc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net359", auto_config: false , :mac => "4438390002c8"
      
      # link for fp1 --> chassis04-lc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net156", auto_config: false , :mac => "443839000135"
      
      # link for fp2 --> chassis04-lc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net525", auto_config: false , :mac => "443839000410"
      
      # link for fp3 --> chassis04-lc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net545", auto_config: false , :mac => "443839000437"
      
      # link for fp4 --> chassis04-lc1-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net130", auto_config: false , :mac => "443839000101"
      
      # link for fp5 --> chassis04-lc1-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net199", auto_config: false , :mac => "44383900018b"
      
      # link for fp6 --> chassis04-lc1-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net415", auto_config: false , :mac => "443839000338"
      
      # link for fp7 --> chassis04-lc1-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net217", auto_config: false , :mac => "4438390001af"
      
      # link for fp8 --> chassis04-lc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net97", auto_config: false , :mac => "4438390000bf"
      
      # link for fp9 --> chassis04-lc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net73", auto_config: false , :mac => "443839000090"
      
      # link for fp10 --> chassis04-lc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net198", auto_config: false , :mac => "443839000189"
      
      # link for fp11 --> chassis04-lc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net31", auto_config: false , :mac => "44383900003d"
      
      # link for fp12 --> chassis04-lc2-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net523", auto_config: false , :mac => "44383900040c"
      
      # link for fp13 --> chassis04-lc2-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net516", auto_config: false , :mac => "4438390003fe"
      
      # link for fp14 --> chassis04-lc2-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net189", auto_config: false , :mac => "443839000177"
      
      # link for fp15 --> chassis04-lc2-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net358", auto_config: false , :mac => "4438390002c6"
      
      # link for fp16 --> chassis04-lc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net49", auto_config: false , :mac => "443839000060"
      
      # link for fp17 --> chassis04-lc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net95", auto_config: false , :mac => "4438390000bb"
      
      # link for fp18 --> chassis04-lc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net213", auto_config: false , :mac => "4438390001a7"
      
      # link for fp19 --> chassis04-lc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net546", auto_config: false , :mac => "443839000439"
      
      # link for fp20 --> chassis04-lc3-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net345", auto_config: false , :mac => "4438390002ac"
      
      # link for fp21 --> chassis04-lc3-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net16", auto_config: false , :mac => "443839000020"
      
      # link for fp22 --> chassis04-lc3-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net173", auto_config: false , :mac => "443839000157"
      
      # link for fp23 --> chassis04-lc3-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net551", auto_config: false , :mac => "443839000443"
      
      # link for fp24 --> chassis04-lc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net191", auto_config: false , :mac => "44383900017b"
      
      # link for fp25 --> chassis04-lc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net177", auto_config: false , :mac => "44383900015f"
      
      # link for fp26 --> chassis04-lc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net351", auto_config: false , :mac => "4438390002b8"
      
      # link for fp27 --> chassis04-lc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net280", auto_config: false , :mac => "44383900022c"
      
      # link for fp28 --> chassis04-lc4-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net367", auto_config: false , :mac => "4438390002d8"
      
      # link for fp29 --> chassis04-lc4-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net220", auto_config: false , :mac => "4438390001b5"
      
      # link for fp30 --> chassis04-lc4-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net10", auto_config: false , :mac => "443839000014"
      
      # link for fp31 --> chassis04-lc4-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net143", auto_config: false , :mac => "44383900011b"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:64 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:64", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c8 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c8", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:35 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:35", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:10 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:10", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:37 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:37", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:01 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:01", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8b --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8b", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:38 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:38", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:af --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:af", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:bf --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:bf", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:90 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:90", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:89 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:89", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3d --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3d", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0c --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0c", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:fe --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:fe", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:77 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:77", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c6 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c6", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:60 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:60", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:bb --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:bb", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a7 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a7", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:39 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:39", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ac --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ac", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:20 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:20", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:57 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:57", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:43 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:43", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7b --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7b", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5f --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5f", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b8 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b8", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2c --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2c", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d8 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d8", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b5 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b5", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:14 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:14", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1b --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1b", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-lc3-2 #####
  config.vm.define "chassis02-lc3-2" do |device|
    
    device.vm.hostname = "chassis02-lc3-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-lc3-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net590", auto_config: false , :mac => "44383900046b"
      
      # link for fp0 --> chassis02-fc1-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net99", auto_config: false , :mac => "4438390000c2"
      
      # link for fp1 --> chassis02-fc1-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net281", auto_config: false , :mac => "44383900022d"
      
      # link for fp2 --> chassis02-fc1-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net301", auto_config: false , :mac => "443839000255"
      
      # link for fp3 --> chassis02-fc1-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net126", auto_config: false , :mac => "4438390000f8"
      
      # link for fp4 --> chassis02-fc2-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net158", auto_config: false , :mac => "443839000138"
      
      # link for fp5 --> chassis02-fc2-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net475", auto_config: false , :mac => "4438390003ad"
      
      # link for fp6 --> chassis02-fc2-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net547", auto_config: false , :mac => "44383900043a"
      
      # link for fp7 --> chassis02-fc2-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net123", auto_config: false , :mac => "4438390000f2"
      
      # link for fp8 --> chassis02-fc3-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net131", auto_config: false , :mac => "443839000102"
      
      # link for fp9 --> chassis02-fc3-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net128", auto_config: false , :mac => "4438390000fc"
      
      # link for fp10 --> chassis02-fc3-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net57", auto_config: false , :mac => "44383900006f"
      
      # link for fp11 --> chassis02-fc3-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net263", auto_config: false , :mac => "44383900020a"
      
      # link for fp12 --> chassis02-fc4-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net531", auto_config: false , :mac => "44383900041a"
      
      # link for fp13 --> chassis02-fc4-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net387", auto_config: false , :mac => "4438390002ff"
      
      # link for fp14 --> chassis02-fc4-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net115", auto_config: false , :mac => "4438390000e2"
      
      # link for fp15 --> chassis02-fc4-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net70", auto_config: false , :mac => "443839000089"
      
      # link for swp6 --> leaf06:swp52
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net262", auto_config: false , :mac => "443839000209"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6b --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6b", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:c2 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:c2", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2d --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2d", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:55 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:55", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f8 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f8", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:38 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:38", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ad --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ad", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3a --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3a", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f2 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f2", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:02 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:02", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:fc --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:fc", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6f --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6f", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0a --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0a", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1a --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1a", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ff --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ff", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e2 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e2", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:89 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:89", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:09 --> swp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:09", NAME="swp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-fc2-1 #####
  config.vm.define "chassis03-fc2-1" do |device|
    
    device.vm.hostname = "chassis03-fc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-fc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net591", auto_config: false , :mac => "44383900046c"
      
      # link for fp0 --> chassis03-lc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net554", auto_config: false , :mac => "443839000448"
      
      # link for fp1 --> chassis03-lc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net304", auto_config: false , :mac => "44383900025b"
      
      # link for fp2 --> chassis03-lc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net105", auto_config: false , :mac => "4438390000cf"
      
      # link for fp3 --> chassis03-lc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net56", auto_config: false , :mac => "44383900006e"
      
      # link for fp4 --> chassis03-lc1-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net113", auto_config: false , :mac => "4438390000df"
      
      # link for fp5 --> chassis03-lc1-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net458", auto_config: false , :mac => "44383900038c"
      
      # link for fp6 --> chassis03-lc1-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net20", auto_config: false , :mac => "443839000028"
      
      # link for fp7 --> chassis03-lc1-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net414", auto_config: false , :mac => "443839000336"
      
      # link for fp8 --> chassis03-lc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net524", auto_config: false , :mac => "44383900040e"
      
      # link for fp9 --> chassis03-lc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net89", auto_config: false , :mac => "4438390000af"
      
      # link for fp10 --> chassis03-lc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net5", auto_config: false , :mac => "44383900000a"
      
      # link for fp11 --> chassis03-lc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net205", auto_config: false , :mac => "443839000197"
      
      # link for fp12 --> chassis03-lc2-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net275", auto_config: false , :mac => "443839000223"
      
      # link for fp13 --> chassis03-lc2-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net69", auto_config: false , :mac => "443839000088"
      
      # link for fp14 --> chassis03-lc2-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net147", auto_config: false , :mac => "443839000123"
      
      # link for fp15 --> chassis03-lc2-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net340", auto_config: false , :mac => "4438390002a2"
      
      # link for fp16 --> chassis03-lc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net107", auto_config: false , :mac => "4438390000d3"
      
      # link for fp17 --> chassis03-lc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net346", auto_config: false , :mac => "4438390002ae"
      
      # link for fp18 --> chassis03-lc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net245", auto_config: false , :mac => "4438390001e7"
      
      # link for fp19 --> chassis03-lc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net216", auto_config: false , :mac => "4438390001ad"
      
      # link for fp20 --> chassis03-lc3-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net108", auto_config: false , :mac => "4438390000d5"
      
      # link for fp21 --> chassis03-lc3-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net308", auto_config: false , :mac => "443839000263"
      
      # link for fp22 --> chassis03-lc3-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net333", auto_config: false , :mac => "443839000294"
      
      # link for fp23 --> chassis03-lc3-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net238", auto_config: false , :mac => "4438390001d9"
      
      # link for fp24 --> chassis03-lc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net76", auto_config: false , :mac => "443839000096"
      
      # link for fp25 --> chassis03-lc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net371", auto_config: false , :mac => "4438390002e0"
      
      # link for fp26 --> chassis03-lc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net59", auto_config: false , :mac => "443839000074"
      
      # link for fp27 --> chassis03-lc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net202", auto_config: false , :mac => "443839000191"
      
      # link for fp28 --> chassis03-lc4-2:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net140", auto_config: false , :mac => "443839000115"
      
      # link for fp29 --> chassis03-lc4-2:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net155", auto_config: false , :mac => "443839000133"
      
      # link for fp30 --> chassis03-lc4-2:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net379", auto_config: false , :mac => "4438390002f0"
      
      # link for fp31 --> chassis03-lc4-2:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net38", auto_config: false , :mac => "44383900004b"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6c --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6c", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:48 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:48", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5b --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5b", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:cf --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:cf", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:6e --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:6e", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:df --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:df", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:8c --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:8c", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:28 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:28", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:36 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:36", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0e --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0e", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:af --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:af", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0a --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0a", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:97 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:97", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:23 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:23", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:88 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:88", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:23 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:23", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a2 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a2", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d3 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d3", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ae --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ae", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e7 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e7", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ad --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ad", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d5 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d5", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:63 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:63", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:94 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:94", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d9 --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d9", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:96 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:96", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e0 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e0", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:74 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:74", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:91 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:91", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:15 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:15", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:33 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:33", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f0 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f0", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4b --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4b", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc1-2 #####
  config.vm.define "chassis01-lc1-2" do |device|
    
    device.vm.hostname = "chassis01-lc1-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc1-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net592", auto_config: false , :mac => "44383900046d"
      
      # link for fp0 --> chassis01-fc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net495", auto_config: false , :mac => "4438390003d5"
      
      # link for fp1 --> chassis01-fc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net302", auto_config: false , :mac => "443839000257"
      
      # link for fp2 --> chassis01-fc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net23", auto_config: false , :mac => "44383900002d"
      
      # link for fp3 --> chassis01-fc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net420", auto_config: false , :mac => "443839000340"
      
      # link for fp4 --> chassis01-fc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net544", auto_config: false , :mac => "443839000434"
      
      # link for fp5 --> chassis01-fc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net517", auto_config: false , :mac => "4438390003ff"
      
      # link for fp6 --> chassis01-fc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net116", auto_config: false , :mac => "4438390000e4"
      
      # link for fp7 --> chassis01-fc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net292", auto_config: false , :mac => "443839000243"
      
      # link for fp8 --> chassis01-fc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net80", auto_config: false , :mac => "44383900009d"
      
      # link for fp9 --> chassis01-fc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net230", auto_config: false , :mac => "4438390001c8"
      
      # link for fp10 --> chassis01-fc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net176", auto_config: false , :mac => "44383900015c"
      
      # link for fp11 --> chassis01-fc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net207", auto_config: false , :mac => "44383900019a"
      
      # link for fp12 --> chassis01-fc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net341", auto_config: false , :mac => "4438390002a3"
      
      # link for fp13 --> chassis01-fc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net412", auto_config: false , :mac => "443839000331"
      
      # link for fp14 --> chassis01-fc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net165", auto_config: false , :mac => "443839000146"
      
      # link for fp15 --> chassis01-fc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net522", auto_config: false , :mac => "443839000409"
      
      # link for swp2 --> leaf02:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net536", auto_config: false , :mac => "443839000425"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6d --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6d", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d5 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d5", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:57 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:57", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2d --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2d", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:40 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:40", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:34 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:34", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ff --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ff", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e4 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e4", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:43 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:43", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9d --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9d", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c8 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c8", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5c --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5c", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9a --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9a", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a3 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a3", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:31 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:31", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:46 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:46", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:09 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:09", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:25 --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:25", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-fc3-1 #####
  config.vm.define "chassis03-fc3-1" do |device|
    
    device.vm.hostname = "chassis03-fc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-fc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net593", auto_config: false , :mac => "44383900046e"
      
      # link for fp0 --> chassis03-lc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net124", auto_config: false , :mac => "4438390000f5"
      
      # link for fp1 --> chassis03-lc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net231", auto_config: false , :mac => "4438390001cb"
      
      # link for fp2 --> chassis03-lc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net331", auto_config: false , :mac => "443839000290"
      
      # link for fp3 --> chassis03-lc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net539", auto_config: false , :mac => "44383900042b"
      
      # link for fp4 --> chassis03-lc1-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net366", auto_config: false , :mac => "4438390002d6"
      
      # link for fp5 --> chassis03-lc1-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net502", auto_config: false , :mac => "4438390003e3"
      
      # link for fp6 --> chassis03-lc1-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net528", auto_config: false , :mac => "443839000416"
      
      # link for fp7 --> chassis03-lc1-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net389", auto_config: false , :mac => "443839000304"
      
      # link for fp8 --> chassis03-lc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net374", auto_config: false , :mac => "4438390002e6"
      
      # link for fp9 --> chassis03-lc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net440", auto_config: false , :mac => "443839000368"
      
      # link for fp10 --> chassis03-lc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net362", auto_config: false , :mac => "4438390002ce"
      
      # link for fp11 --> chassis03-lc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net51", auto_config: false , :mac => "443839000064"
      
      # link for fp12 --> chassis03-lc2-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net413", auto_config: false , :mac => "443839000334"
      
      # link for fp13 --> chassis03-lc2-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net33", auto_config: false , :mac => "443839000041"
      
      # link for fp14 --> chassis03-lc2-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net208", auto_config: false , :mac => "44383900019d"
      
      # link for fp15 --> chassis03-lc2-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net18", auto_config: false , :mac => "443839000024"
      
      # link for fp16 --> chassis03-lc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net153", auto_config: false , :mac => "44383900012f"
      
      # link for fp17 --> chassis03-lc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net90", auto_config: false , :mac => "4438390000b1"
      
      # link for fp18 --> chassis03-lc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net335", auto_config: false , :mac => "443839000298"
      
      # link for fp19 --> chassis03-lc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net485", auto_config: false , :mac => "4438390003c2"
      
      # link for fp20 --> chassis03-lc3-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net424", auto_config: false , :mac => "443839000349"
      
      # link for fp21 --> chassis03-lc3-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net307", auto_config: false , :mac => "443839000261"
      
      # link for fp22 --> chassis03-lc3-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net244", auto_config: false , :mac => "4438390001e5"
      
      # link for fp23 --> chassis03-lc3-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net306", auto_config: false , :mac => "44383900025f"
      
      # link for fp24 --> chassis03-lc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net193", auto_config: false , :mac => "44383900017f"
      
      # link for fp25 --> chassis03-lc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net323", auto_config: false , :mac => "443839000280"
      
      # link for fp26 --> chassis03-lc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net60", auto_config: false , :mac => "443839000076"
      
      # link for fp27 --> chassis03-lc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net46", auto_config: false , :mac => "44383900005a"
      
      # link for fp28 --> chassis03-lc4-2:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net354", auto_config: false , :mac => "4438390002be"
      
      # link for fp29 --> chassis03-lc4-2:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net399", auto_config: false , :mac => "443839000318"
      
      # link for fp30 --> chassis03-lc4-2:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net150", auto_config: false , :mac => "443839000129"
      
      # link for fp31 --> chassis03-lc4-2:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net15", auto_config: false , :mac => "44383900001e"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6e --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6e", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f5 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f5", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:cb --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:cb", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:90 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:90", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2b --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2b", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d6 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d6", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e3 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e3", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:16 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:16", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:04 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:04", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e6 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e6", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:68 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:68", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ce --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ce", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:64 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:64", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:34 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:34", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:41 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:41", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9d --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9d", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:24 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:24", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2f --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2f", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b1 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b1", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:98 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:98", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c2 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c2", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:49 --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:49", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:61 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:61", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e5 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e5", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:5f --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:5f", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7f --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7f", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:80 --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:80", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:76 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:76", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:5a --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:5a", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:be --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:be", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:18 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:18", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:29 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:29", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1e --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1e", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc1-1 #####
  config.vm.define "chassis01-lc1-1" do |device|
    
    device.vm.hostname = "chassis01-lc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net594", auto_config: false , :mac => "44383900046f"
      
      # link for fp0 --> chassis01-fc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net254", auto_config: false , :mac => "4438390001f8"
      
      # link for fp1 --> chassis01-fc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net509", auto_config: false , :mac => "4438390003ef"
      
      # link for fp2 --> chassis01-fc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net434", auto_config: false , :mac => "44383900035c"
      
      # link for fp3 --> chassis01-fc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net182", auto_config: false , :mac => "443839000168"
      
      # link for fp4 --> chassis01-fc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net476", auto_config: false , :mac => "4438390003af"
      
      # link for fp5 --> chassis01-fc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net268", auto_config: false , :mac => "443839000214"
      
      # link for fp6 --> chassis01-fc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net311", auto_config: false , :mac => "443839000268"
      
      # link for fp7 --> chassis01-fc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net278", auto_config: false , :mac => "443839000227"
      
      # link for fp8 --> chassis01-fc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net421", auto_config: false , :mac => "443839000342"
      
      # link for fp9 --> chassis01-fc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net533", auto_config: false , :mac => "44383900041e"
      
      # link for fp10 --> chassis01-fc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net393", auto_config: false , :mac => "44383900030b"
      
      # link for fp11 --> chassis01-fc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net507", auto_config: false , :mac => "4438390003eb"
      
      # link for fp12 --> chassis01-fc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net96", auto_config: false , :mac => "4438390000bc"
      
      # link for fp13 --> chassis01-fc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net508", auto_config: false , :mac => "4438390003ed"
      
      # link for fp14 --> chassis01-fc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net378", auto_config: false , :mac => "4438390002ed"
      
      # link for fp15 --> chassis01-fc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net78", auto_config: false , :mac => "443839000099"
      
      # link for swp1 --> leaf01:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net154", auto_config: false , :mac => "443839000131"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6f --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6f", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f8 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f8", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ef --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ef", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5c --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5c", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:68 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:68", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:af --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:af", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:14 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:14", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:68 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:68", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:27 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:27", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:42 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:42", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0b --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0b", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:eb --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:eb", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:bc --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:bc", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ed --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ed", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ed --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ed", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:99 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:99", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:31 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:31", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc1-2 #####
  config.vm.define "chassis04-lc1-2" do |device|
    
    device.vm.hostname = "chassis04-lc1-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc1-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net595", auto_config: false , :mac => "443839000470"
      
      # link for fp0 --> chassis04-fc1-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net377", auto_config: false , :mac => "4438390002eb"
      
      # link for fp1 --> chassis04-fc1-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net353", auto_config: false , :mac => "4438390002bb"
      
      # link for fp2 --> chassis04-fc1-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net352", auto_config: false , :mac => "4438390002b9"
      
      # link for fp3 --> chassis04-fc1-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net392", auto_config: false , :mac => "443839000309"
      
      # link for fp4 --> chassis04-fc2-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net330", auto_config: false , :mac => "44383900028d"
      
      # link for fp5 --> chassis04-fc2-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net463", auto_config: false , :mac => "443839000395"
      
      # link for fp6 --> chassis04-fc2-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net141", auto_config: false , :mac => "443839000116"
      
      # link for fp7 --> chassis04-fc2-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net170", auto_config: false , :mac => "443839000150"
      
      # link for fp8 --> chassis04-fc3-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net411", auto_config: false , :mac => "44383900032f"
      
      # link for fp9 --> chassis04-fc3-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net553", auto_config: false , :mac => "443839000445"
      
      # link for fp10 --> chassis04-fc3-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net162", auto_config: false , :mac => "443839000140"
      
      # link for fp11 --> chassis04-fc3-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net457", auto_config: false , :mac => "443839000389"
      
      # link for fp12 --> chassis04-fc4-1:fp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net130", auto_config: false , :mac => "443839000100"
      
      # link for fp13 --> chassis04-fc4-1:fp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net199", auto_config: false , :mac => "44383900018a"
      
      # link for fp14 --> chassis04-fc4-1:fp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net415", auto_config: false , :mac => "443839000337"
      
      # link for fp15 --> chassis04-fc4-1:fp7
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net217", auto_config: false , :mac => "4438390001ae"
      
      # link for swp2 --> leaf02:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net149", auto_config: false , :mac => "443839000127"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:70 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:70", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:eb --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:eb", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:bb --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:bb", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b9 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b9", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:09 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:09", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:8d --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:8d", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:95 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:95", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:16 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:16", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:50 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:50", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2f --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2f", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:45 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:45", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:40 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:40", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:89 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:89", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:00 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:00", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8a --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8a", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:37 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:37", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ae --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ae", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:27 --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:27", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc1-1 #####
  config.vm.define "chassis04-lc1-1" do |device|
    
    device.vm.hostname = "chassis04-lc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net596", auto_config: false , :mac => "443839000471"
      
      # link for fp0 --> chassis04-fc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net385", auto_config: false , :mac => "4438390002fb"
      
      # link for fp1 --> chassis04-fc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net104", auto_config: false , :mac => "4438390000cc"
      
      # link for fp2 --> chassis04-fc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net271", auto_config: false , :mac => "44383900021a"
      
      # link for fp3 --> chassis04-fc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net65", auto_config: false , :mac => "44383900007f"
      
      # link for fp4 --> chassis04-fc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net118", auto_config: false , :mac => "4438390000e8"
      
      # link for fp5 --> chassis04-fc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net171", auto_config: false , :mac => "443839000152"
      
      # link for fp6 --> chassis04-fc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net287", auto_config: false , :mac => "443839000239"
      
      # link for fp7 --> chassis04-fc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net480", auto_config: false , :mac => "4438390003b7"
      
      # link for fp8 --> chassis04-fc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net519", auto_config: false , :mac => "443839000403"
      
      # link for fp9 --> chassis04-fc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net541", auto_config: false , :mac => "44383900042e"
      
      # link for fp10 --> chassis04-fc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net297", auto_config: false , :mac => "44383900024d"
      
      # link for fp11 --> chassis04-fc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net219", auto_config: false , :mac => "4438390001b2"
      
      # link for fp12 --> chassis04-fc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net359", auto_config: false , :mac => "4438390002c7"
      
      # link for fp13 --> chassis04-fc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net156", auto_config: false , :mac => "443839000134"
      
      # link for fp14 --> chassis04-fc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net525", auto_config: false , :mac => "44383900040f"
      
      # link for fp15 --> chassis04-fc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net545", auto_config: false , :mac => "443839000436"
      
      # link for swp1 --> leaf01:swp54
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net68", auto_config: false , :mac => "443839000086"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:71 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:71", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:fb --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:fb", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:cc --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:cc", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1a --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1a", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7f --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7f", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e8 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e8", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:52 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:52", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:39 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:39", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b7 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b7", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:03 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:03", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4d --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4d", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b2 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b2", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c7 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c7", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:34 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:34", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:0f --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:0f", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:36 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:36", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:86 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:86", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-fc1-1 #####
  config.vm.define "chassis03-fc1-1" do |device|
    
    device.vm.hostname = "chassis03-fc1-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-fc1-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net597", auto_config: false , :mac => "443839000472"
      
      # link for fp0 --> chassis03-lc1-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net444", auto_config: false , :mac => "443839000370"
      
      # link for fp1 --> chassis03-lc1-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net192", auto_config: false , :mac => "44383900017d"
      
      # link for fp2 --> chassis03-lc1-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net481", auto_config: false , :mac => "4438390003ba"
      
      # link for fp3 --> chassis03-lc1-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net532", auto_config: false , :mac => "44383900041d"
      
      # link for fp4 --> chassis03-lc1-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net282", auto_config: false , :mac => "443839000230"
      
      # link for fp5 --> chassis03-lc1-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net326", auto_config: false , :mac => "443839000286"
      
      # link for fp6 --> chassis03-lc1-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net212", auto_config: false , :mac => "4438390001a5"
      
      # link for fp7 --> chassis03-lc1-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net4", auto_config: false , :mac => "443839000008"
      
      # link for fp8 --> chassis03-lc2-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net249", auto_config: false , :mac => "4438390001ef"
      
      # link for fp9 --> chassis03-lc2-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net520", auto_config: false , :mac => "443839000406"
      
      # link for fp10 --> chassis03-lc2-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net503", auto_config: false , :mac => "4438390003e5"
      
      # link for fp11 --> chassis03-lc2-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net181", auto_config: false , :mac => "443839000167"
      
      # link for fp12 --> chassis03-lc2-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net50", auto_config: false , :mac => "443839000062"
      
      # link for fp13 --> chassis03-lc2-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net252", auto_config: false , :mac => "4438390001f5"
      
      # link for fp14 --> chassis03-lc2-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net513", auto_config: false , :mac => "4438390003f8"
      
      # link for fp15 --> chassis03-lc2-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net14", auto_config: false , :mac => "44383900001c"
      
      # link for fp16 --> chassis03-lc3-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net407", auto_config: false , :mac => "443839000328"
      
      # link for fp17 --> chassis03-lc3-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net441", auto_config: false , :mac => "44383900036a"
      
      # link for fp18 --> chassis03-lc3-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net472", auto_config: false , :mac => "4438390003a8"
      
      # link for fp19 --> chassis03-lc3-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net227", auto_config: false , :mac => "4438390001c3"
      
      # link for fp20 --> chassis03-lc3-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net369", auto_config: false , :mac => "4438390002dc"
      
      # link for fp21 --> chassis03-lc3-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net442", auto_config: false , :mac => "44383900036c"
      
      # link for fp22 --> chassis03-lc3-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net209", auto_config: false , :mac => "44383900019f"
      
      # link for fp23 --> chassis03-lc3-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net62", auto_config: false , :mac => "44383900007a"
      
      # link for fp24 --> chassis03-lc4-1:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net382", auto_config: false , :mac => "4438390002f6"
      
      # link for fp25 --> chassis03-lc4-1:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net111", auto_config: false , :mac => "4438390000db"
      
      # link for fp26 --> chassis03-lc4-1:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net468", auto_config: false , :mac => "4438390003a0"
      
      # link for fp27 --> chassis03-lc4-1:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net500", auto_config: false , :mac => "4438390003df"
      
      # link for fp28 --> chassis03-lc4-2:fp0
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net159", auto_config: false , :mac => "44383900013b"
      
      # link for fp29 --> chassis03-lc4-2:fp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net272", auto_config: false , :mac => "44383900021d"
      
      # link for fp30 --> chassis03-lc4-2:fp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net373", auto_config: false , :mac => "4438390002e4"
      
      # link for fp31 --> chassis03-lc4-2:fp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net64", auto_config: false , :mac => "44383900007e"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:72 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:72", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:70 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:70", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7d --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7d", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ba --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ba", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1d --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1d", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:30 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:30", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:86 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:86", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a5 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a5", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:08 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:08", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ef --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ef", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:06 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:06", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e5 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e5", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:67 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:67", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:62 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:62", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f5 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f5", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f8 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f8", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1c --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1c", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:28 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:28", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6a --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6a", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a8 --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a8", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c3 --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c3", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:dc --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:dc", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:6c --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:6c", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9f --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9f", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7a --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7a", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f6 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f6", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:db --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:db", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a0 --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a0", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:df --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:df", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3b --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3b", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1d --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1d", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e4 --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e4", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7e --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7e", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc2-2 #####
  config.vm.define "chassis03-lc2-2" do |device|
    
    device.vm.hostname = "chassis03-lc2-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc2-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net598", auto_config: false , :mac => "443839000473"
      
      # link for fp0 --> chassis03-fc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net50", auto_config: false , :mac => "443839000061"
      
      # link for fp1 --> chassis03-fc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net252", auto_config: false , :mac => "4438390001f4"
      
      # link for fp2 --> chassis03-fc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net513", auto_config: false , :mac => "4438390003f7"
      
      # link for fp3 --> chassis03-fc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net14", auto_config: false , :mac => "44383900001b"
      
      # link for fp4 --> chassis03-fc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net275", auto_config: false , :mac => "443839000222"
      
      # link for fp5 --> chassis03-fc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net69", auto_config: false , :mac => "443839000087"
      
      # link for fp6 --> chassis03-fc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net147", auto_config: false , :mac => "443839000122"
      
      # link for fp7 --> chassis03-fc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net340", auto_config: false , :mac => "4438390002a1"
      
      # link for fp8 --> chassis03-fc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net413", auto_config: false , :mac => "443839000333"
      
      # link for fp9 --> chassis03-fc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net33", auto_config: false , :mac => "443839000040"
      
      # link for fp10 --> chassis03-fc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net208", auto_config: false , :mac => "44383900019c"
      
      # link for fp11 --> chassis03-fc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net18", auto_config: false , :mac => "443839000023"
      
      # link for fp12 --> chassis03-fc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net478", auto_config: false , :mac => "4438390003b3"
      
      # link for fp13 --> chassis03-fc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net183", auto_config: false , :mac => "44383900016a"
      
      # link for fp14 --> chassis03-fc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net136", auto_config: false , :mac => "44383900010c"
      
      # link for fp15 --> chassis03-fc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net257", auto_config: false , :mac => "4438390001fe"
      
      # link for swp4 --> leaf04:swp53
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net537", auto_config: false , :mac => "443839000427"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:73 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:73", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:61 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:61", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f4 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f4", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f7 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f7", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1b --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1b", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:22 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:22", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:87 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:87", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:22 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:22", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a1 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a1", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:33 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:33", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:40 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:40", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:9c --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:9c", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:23 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:23", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b3 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b3", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6a --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6a", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0c --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0c", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:fe --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:fe", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:27 --> swp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:27", NAME="swp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc4-2 #####
  config.vm.define "chassis01-lc4-2" do |device|
    
    device.vm.hostname = "chassis01-lc4-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc4-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net599", auto_config: false , :mac => "443839000474"
      
      # link for fp0 --> chassis01-fc1-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net337", auto_config: false , :mac => "44383900029b"
      
      # link for fp1 --> chassis01-fc1-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net446", auto_config: false , :mac => "443839000373"
      
      # link for fp2 --> chassis01-fc1-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net3", auto_config: false , :mac => "443839000005"
      
      # link for fp3 --> chassis01-fc1-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net438", auto_config: false , :mac => "443839000363"
      
      # link for fp4 --> chassis01-fc2-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net427", auto_config: false , :mac => "44383900034e"
      
      # link for fp5 --> chassis01-fc2-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net267", auto_config: false , :mac => "443839000212"
      
      # link for fp6 --> chassis01-fc2-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net388", auto_config: false , :mac => "443839000301"
      
      # link for fp7 --> chassis01-fc2-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net34", auto_config: false , :mac => "443839000042"
      
      # link for fp8 --> chassis01-fc3-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net163", auto_config: false , :mac => "443839000142"
      
      # link for fp9 --> chassis01-fc3-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net169", auto_config: false , :mac => "44383900014e"
      
      # link for fp10 --> chassis01-fc3-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net106", auto_config: false , :mac => "4438390000d0"
      
      # link for fp11 --> chassis01-fc3-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net273", auto_config: false , :mac => "44383900021e"
      
      # link for fp12 --> chassis01-fc4-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net25", auto_config: false , :mac => "443839000031"
      
      # link for fp13 --> chassis01-fc4-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net477", auto_config: false , :mac => "4438390003b1"
      
      # link for fp14 --> chassis01-fc4-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net8", auto_config: false , :mac => "44383900000f"
      
      # link for fp15 --> chassis01-fc4-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net321", auto_config: false , :mac => "44383900027b"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:74 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:74", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9b --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9b", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:73 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:73", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:05 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:05", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:63 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:63", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4e --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4e", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:12 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:12", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:01 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:01", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:42 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:42", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:42 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:42", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4e --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4e", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d0 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d0", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1e --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1e", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:31 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:31", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:b1 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:b1", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0f --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0f", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7b --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7b", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc4-1 #####
  config.vm.define "chassis01-lc4-1" do |device|
    
    device.vm.hostname = "chassis01-lc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net600", auto_config: false , :mac => "443839000475"
      
      # link for fp0 --> chassis01-fc1-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net42", auto_config: false , :mac => "443839000051"
      
      # link for fp1 --> chassis01-fc1-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net534", auto_config: false , :mac => "443839000420"
      
      # link for fp2 --> chassis01-fc1-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net151", auto_config: false , :mac => "44383900012a"
      
      # link for fp3 --> chassis01-fc1-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net465", auto_config: false , :mac => "443839000399"
      
      # link for fp4 --> chassis01-fc2-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net473", auto_config: false , :mac => "4438390003a9"
      
      # link for fp5 --> chassis01-fc2-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net406", auto_config: false , :mac => "443839000325"
      
      # link for fp6 --> chassis01-fc2-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net239", auto_config: false , :mac => "4438390001da"
      
      # link for fp7 --> chassis01-fc2-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net167", auto_config: false , :mac => "44383900014a"
      
      # link for fp8 --> chassis01-fc3-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net122", auto_config: false , :mac => "4438390000f0"
      
      # link for fp9 --> chassis01-fc3-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net133", auto_config: false , :mac => "443839000106"
      
      # link for fp10 --> chassis01-fc3-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net233", auto_config: false , :mac => "4438390001ce"
      
      # link for fp11 --> chassis01-fc3-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net256", auto_config: false , :mac => "4438390001fc"
      
      # link for fp12 --> chassis01-fc4-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net474", auto_config: false , :mac => "4438390003ab"
      
      # link for fp13 --> chassis01-fc4-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net146", auto_config: false , :mac => "443839000120"
      
      # link for fp14 --> chassis01-fc4-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net226", auto_config: false , :mac => "4438390001c0"
      
      # link for fp15 --> chassis01-fc4-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net185", auto_config: false , :mac => "44383900016e"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:75 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:75", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:51 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:51", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:20 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:20", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:2a --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:2a", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:99 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:99", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a9 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a9", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:25 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:25", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:da --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:da", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f0 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f0", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:06 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:06", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ce --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ce", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:fc --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:fc", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ab --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ab", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:20 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:20", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c0 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c0", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:6e --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:6e", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc2-1 #####
  config.vm.define "chassis01-lc2-1" do |device|
    
    device.vm.hostname = "chassis01-lc2-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc2-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net601", auto_config: false , :mac => "443839000476"
      
      # link for fp0 --> chassis01-fc1-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net318", auto_config: false , :mac => "443839000275"
      
      # link for fp1 --> chassis01-fc1-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net317", auto_config: false , :mac => "443839000273"
      
      # link for fp2 --> chassis01-fc1-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net360", auto_config: false , :mac => "4438390002c9"
      
      # link for fp3 --> chassis01-fc1-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net295", auto_config: false , :mac => "443839000249"
      
      # link for fp4 --> chassis01-fc2-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net264", auto_config: false , :mac => "44383900020c"
      
      # link for fp5 --> chassis01-fc2-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net7", auto_config: false , :mac => "44383900000d"
      
      # link for fp6 --> chassis01-fc2-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net342", auto_config: false , :mac => "4438390002a5"
      
      # link for fp7 --> chassis01-fc2-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net431", auto_config: false , :mac => "443839000356"
      
      # link for fp8 --> chassis01-fc3-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net1", auto_config: false , :mac => "443839000001"
      
      # link for fp9 --> chassis01-fc3-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net467", auto_config: false , :mac => "44383900039d"
      
      # link for fp10 --> chassis01-fc3-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net232", auto_config: false , :mac => "4438390001cc"
      
      # link for fp11 --> chassis01-fc3-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net432", auto_config: false , :mac => "443839000358"
      
      # link for fp12 --> chassis01-fc4-1:fp8
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net253", auto_config: false , :mac => "4438390001f6"
      
      # link for fp13 --> chassis01-fc4-1:fp9
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net456", auto_config: false , :mac => "443839000387"
      
      # link for fp14 --> chassis01-fc4-1:fp10
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net39", auto_config: false , :mac => "44383900004c"
      
      # link for fp15 --> chassis01-fc4-1:fp11
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net114", auto_config: false , :mac => "4438390000e0"
      
      # link for swp3 --> leaf03:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net464", auto_config: false , :mac => "443839000398"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:76 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:76", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:75 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:75", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:73 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:73", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c9 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c9", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:49 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:49", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:0c --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:0c", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0d --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0d", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a5 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a5", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:56 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:56", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:01 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:01", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9d --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9d", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:cc --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:cc", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:58 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:58", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f6 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f6", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:87 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:87", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4c --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4c", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e0 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e0", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:98 --> swp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:98", NAME="swp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc4-1 #####
  config.vm.define "chassis03-lc4-1" do |device|
    
    device.vm.hostname = "chassis03-lc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net602", auto_config: false , :mac => "443839000477"
      
      # link for fp0 --> chassis03-fc1-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net382", auto_config: false , :mac => "4438390002f5"
      
      # link for fp1 --> chassis03-fc1-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net111", auto_config: false , :mac => "4438390000da"
      
      # link for fp2 --> chassis03-fc1-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net468", auto_config: false , :mac => "44383900039f"
      
      # link for fp3 --> chassis03-fc1-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net500", auto_config: false , :mac => "4438390003de"
      
      # link for fp4 --> chassis03-fc2-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net76", auto_config: false , :mac => "443839000095"
      
      # link for fp5 --> chassis03-fc2-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net371", auto_config: false , :mac => "4438390002df"
      
      # link for fp6 --> chassis03-fc2-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net59", auto_config: false , :mac => "443839000073"
      
      # link for fp7 --> chassis03-fc2-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net202", auto_config: false , :mac => "443839000190"
      
      # link for fp8 --> chassis03-fc3-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net193", auto_config: false , :mac => "44383900017e"
      
      # link for fp9 --> chassis03-fc3-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net323", auto_config: false , :mac => "44383900027f"
      
      # link for fp10 --> chassis03-fc3-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net60", auto_config: false , :mac => "443839000075"
      
      # link for fp11 --> chassis03-fc3-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net46", auto_config: false , :mac => "443839000059"
      
      # link for fp12 --> chassis03-fc4-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net542", auto_config: false , :mac => "443839000430"
      
      # link for fp13 --> chassis03-fc4-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net549", auto_config: false , :mac => "44383900043e"
      
      # link for fp14 --> chassis03-fc4-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net550", auto_config: false , :mac => "443839000440"
      
      # link for fp15 --> chassis03-fc4-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net67", auto_config: false , :mac => "443839000083"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:77 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:77", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f5 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f5", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:da --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:da", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:9f --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:9f", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:de --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:de", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:95 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:95", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:df --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:df", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:73 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:73", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:90 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:90", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7e --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7e", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:7f --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:7f", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:75 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:75", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:59 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:59", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:30 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:30", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3e --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3e", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:40 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:40", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:83 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:83", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc2-2 #####
  config.vm.define "chassis01-lc2-2" do |device|
    
    device.vm.hostname = "chassis01-lc2-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc2-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net603", auto_config: false , :mac => "443839000478"
      
      # link for fp0 --> chassis01-fc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net486", auto_config: false , :mac => "4438390003c3"
      
      # link for fp1 --> chassis01-fc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net390", auto_config: false , :mac => "443839000305"
      
      # link for fp2 --> chassis01-fc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net110", auto_config: false , :mac => "4438390000d8"
      
      # link for fp3 --> chassis01-fc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net402", auto_config: false , :mac => "44383900031d"
      
      # link for fp4 --> chassis01-fc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net242", auto_config: false , :mac => "4438390001e0"
      
      # link for fp5 --> chassis01-fc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net27", auto_config: false , :mac => "443839000034"
      
      # link for fp6 --> chassis01-fc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net211", auto_config: false , :mac => "4438390001a2"
      
      # link for fp7 --> chassis01-fc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net428", auto_config: false , :mac => "443839000350"
      
      # link for fp8 --> chassis01-fc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net247", auto_config: false , :mac => "4438390001ea"
      
      # link for fp9 --> chassis01-fc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net13", auto_config: false , :mac => "443839000019"
      
      # link for fp10 --> chassis01-fc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net32", auto_config: false , :mac => "44383900003e"
      
      # link for fp11 --> chassis01-fc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net450", auto_config: false , :mac => "44383900037b"
      
      # link for fp12 --> chassis01-fc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net484", auto_config: false , :mac => "4438390003bf"
      
      # link for fp13 --> chassis01-fc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net168", auto_config: false , :mac => "44383900014c"
      
      # link for fp14 --> chassis01-fc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net493", auto_config: false , :mac => "4438390003d1"
      
      # link for fp15 --> chassis01-fc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net196", auto_config: false , :mac => "443839000184"
      
      # link for swp4 --> leaf04:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net334", auto_config: false , :mac => "443839000296"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:78 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:78", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c3 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c3", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:05 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:05", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:d8 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:d8", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:1d --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:1d", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e0 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e0", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:34 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:34", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a2 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a2", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:50 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:50", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:ea --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:ea", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:19 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:19", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3e --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3e", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7b --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7b", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:bf --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:bf", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:4c --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:4c", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d1 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d1", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:84 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:84", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:96 --> swp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:96", NAME="swp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc3-1 #####
  config.vm.define "chassis01-lc3-1" do |device|
    
    device.vm.hostname = "chassis01-lc3-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc3-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net604", auto_config: false , :mac => "443839000479"
      
      # link for fp0 --> chassis01-fc1-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net437", auto_config: false , :mac => "443839000361"
      
      # link for fp1 --> chassis01-fc1-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net125", auto_config: false , :mac => "4438390000f6"
      
      # link for fp2 --> chassis01-fc1-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net494", auto_config: false , :mac => "4438390003d3"
      
      # link for fp3 --> chassis01-fc1-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net426", auto_config: false , :mac => "44383900034c"
      
      # link for fp4 --> chassis01-fc2-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net200", auto_config: false , :mac => "44383900018c"
      
      # link for fp5 --> chassis01-fc2-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net293", auto_config: false , :mac => "443839000245"
      
      # link for fp6 --> chassis01-fc2-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net135", auto_config: false , :mac => "44383900010a"
      
      # link for fp7 --> chassis01-fc2-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net92", auto_config: false , :mac => "4438390000b4"
      
      # link for fp8 --> chassis01-fc3-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net24", auto_config: false , :mac => "44383900002f"
      
      # link for fp9 --> chassis01-fc3-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net30", auto_config: false , :mac => "44383900003a"
      
      # link for fp10 --> chassis01-fc3-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net445", auto_config: false , :mac => "443839000371"
      
      # link for fp11 --> chassis01-fc3-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net339", auto_config: false , :mac => "44383900029f"
      
      # link for fp12 --> chassis01-fc4-1:fp16
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net349", auto_config: false , :mac => "4438390002b3"
      
      # link for fp13 --> chassis01-fc4-1:fp17
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net129", auto_config: false , :mac => "4438390000fe"
      
      # link for fp14 --> chassis01-fc4-1:fp18
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net2", auto_config: false , :mac => "443839000003"
      
      # link for fp15 --> chassis01-fc4-1:fp19
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net540", auto_config: false , :mac => "44383900042c"
      
      # link for swp5 --> leaf05:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net81", auto_config: false , :mac => "4438390000a0"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:79 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:79", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:61 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:61", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:f6 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:f6", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d3 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d3", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:4c --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:4c", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:8c --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:8c", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:45 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:45", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:0a --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:0a", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b4 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b4", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:2f --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:2f", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:3a --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:3a", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:71 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:71", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:9f --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:9f", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b3 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b3", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:fe --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:fe", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:03 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:03", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:2c --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:2c", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a0 --> swp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a0", NAME="swp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis01-lc3-2 #####
  config.vm.define "chassis01-lc3-2" do |device|
    
    device.vm.hostname = "chassis01-lc3-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis01-lc3-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net605", auto_config: false , :mac => "44383900047a"
      
      # link for fp0 --> chassis01-fc1-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net471", auto_config: false , :mac => "4438390003a5"
      
      # link for fp1 --> chassis01-fc1-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net372", auto_config: false , :mac => "4438390002e1"
      
      # link for fp2 --> chassis01-fc1-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net313", auto_config: false , :mac => "44383900026c"
      
      # link for fp3 --> chassis01-fc1-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net37", auto_config: false , :mac => "443839000048"
      
      # link for fp4 --> chassis01-fc2-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net71", auto_config: false , :mac => "44383900008b"
      
      # link for fp5 --> chassis01-fc2-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net404", auto_config: false , :mac => "443839000321"
      
      # link for fp6 --> chassis01-fc2-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net58", auto_config: false , :mac => "443839000071"
      
      # link for fp7 --> chassis01-fc2-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net29", auto_config: false , :mac => "443839000038"
      
      # link for fp8 --> chassis01-fc3-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net188", auto_config: false , :mac => "443839000174"
      
      # link for fp9 --> chassis01-fc3-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net315", auto_config: false , :mac => "443839000270"
      
      # link for fp10 --> chassis01-fc3-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net328", auto_config: false , :mac => "443839000289"
      
      # link for fp11 --> chassis01-fc3-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net243", auto_config: false , :mac => "4438390001e2"
      
      # link for fp12 --> chassis01-fc4-1:fp20
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net381", auto_config: false , :mac => "4438390002f3"
      
      # link for fp13 --> chassis01-fc4-1:fp21
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net386", auto_config: false , :mac => "4438390002fd"
      
      # link for fp14 --> chassis01-fc4-1:fp22
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net139", auto_config: false , :mac => "443839000112"
      
      # link for fp15 --> chassis01-fc4-1:fp23
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net298", auto_config: false , :mac => "44383900024f"
      
      # link for swp6 --> leaf06:swp51
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net224", auto_config: false , :mac => "4438390001bd"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:7a --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:7a", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:a5 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:a5", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e1 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e1", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6c --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6c", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:48 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:48", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8b --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8b", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:21 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:21", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:71 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:71", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:38 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:38", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:74 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:74", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:70 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:70", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:89 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:89", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:e2 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:e2", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f3 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f3", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:fd --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:fd", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:12 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:12", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:4f --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:4f", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:bd --> swp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:bd", NAME="swp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis02-fc4-1 #####
  config.vm.define "chassis02-fc4-1" do |device|
    
    device.vm.hostname = "chassis02-fc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis02-fc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net606", auto_config: false , :mac => "44383900047b"
      
      # link for fp0 --> chassis02-lc1-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net403", auto_config: false , :mac => "443839000320"
      
      # link for fp1 --> chassis02-lc1-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net409", auto_config: false , :mac => "44383900032c"
      
      # link for fp2 --> chassis02-lc1-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net422", auto_config: false , :mac => "443839000345"
      
      # link for fp3 --> chassis02-lc1-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net499", auto_config: false , :mac => "4438390003dd"
      
      # link for fp4 --> chassis02-lc1-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net356", auto_config: false , :mac => "4438390002c2"
      
      # link for fp5 --> chassis02-lc1-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net376", auto_config: false , :mac => "4438390002ea"
      
      # link for fp6 --> chassis02-lc1-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net461", auto_config: false , :mac => "443839000392"
      
      # link for fp7 --> chassis02-lc1-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net423", auto_config: false , :mac => "443839000347"
      
      # link for fp8 --> chassis02-lc2-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net19", auto_config: false , :mac => "443839000026"
      
      # link for fp9 --> chassis02-lc2-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net348", auto_config: false , :mac => "4438390002b2"
      
      # link for fp10 --> chassis02-lc2-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net286", auto_config: false , :mac => "443839000238"
      
      # link for fp11 --> chassis02-lc2-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net250", auto_config: false , :mac => "4438390001f1"
      
      # link for fp12 --> chassis02-lc2-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net439", auto_config: false , :mac => "443839000366"
      
      # link for fp13 --> chassis02-lc2-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net490", auto_config: false , :mac => "4438390003cc"
      
      # link for fp14 --> chassis02-lc2-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net526", auto_config: false , :mac => "443839000412"
      
      # link for fp15 --> chassis02-lc2-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net312", auto_config: false , :mac => "44383900026b"
      
      # link for fp16 --> chassis02-lc3-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net61", auto_config: false , :mac => "443839000078"
      
      # link for fp17 --> chassis02-lc3-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net134", auto_config: false , :mac => "443839000109"
      
      # link for fp18 --> chassis02-lc3-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net103", auto_config: false , :mac => "4438390000cb"
      
      # link for fp19 --> chassis02-lc3-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net394", auto_config: false , :mac => "44383900030e"
      
      # link for fp20 --> chassis02-lc3-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net531", auto_config: false , :mac => "44383900041b"
      
      # link for fp21 --> chassis02-lc3-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net387", auto_config: false , :mac => "443839000300"
      
      # link for fp22 --> chassis02-lc3-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net115", auto_config: false , :mac => "4438390000e3"
      
      # link for fp23 --> chassis02-lc3-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net70", auto_config: false , :mac => "44383900008a"
      
      # link for fp24 --> chassis02-lc4-1:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net258", auto_config: false , :mac => "443839000201"
      
      # link for fp25 --> chassis02-lc4-1:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net451", auto_config: false , :mac => "44383900037e"
      
      # link for fp26 --> chassis02-lc4-1:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net289", auto_config: false , :mac => "44383900023e"
      
      # link for fp27 --> chassis02-lc4-1:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net44", auto_config: false , :mac => "443839000056"
      
      # link for fp28 --> chassis02-lc4-2:fp12
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net195", auto_config: false , :mac => "443839000183"
      
      # link for fp29 --> chassis02-lc4-2:fp13
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net391", auto_config: false , :mac => "443839000308"
      
      # link for fp30 --> chassis02-lc4-2:fp14
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net418", auto_config: false , :mac => "44383900033d"
      
      # link for fp31 --> chassis02-lc4-2:fp15
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net164", auto_config: false , :mac => "443839000145"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc19', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc20', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc21', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc22', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc23', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc24', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc25', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc26', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc27', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc28', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc29', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc30', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc31', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc32', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc33', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc34', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:7b --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:7b", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:20 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:20", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2c --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2c", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:45 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:45", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:dd --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:dd", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:c2 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:c2", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ea --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ea", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:92 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:92", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:47 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:47", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:26 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:26", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b2 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b2", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:38 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:38", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:f1 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:f1", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:66 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:66", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:cc --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:cc", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:12 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:12", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6b --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6b", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:78 --> fp16"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:78", NAME="fp16", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:09 --> fp17"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:09", NAME="fp17", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:cb --> fp18"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:cb", NAME="fp18", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:0e --> fp19"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:0e", NAME="fp19", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:1b --> fp20"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:1b", NAME="fp20", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:00 --> fp21"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:00", NAME="fp21", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:e3 --> fp22"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:e3", NAME="fp22", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:8a --> fp23"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:8a", NAME="fp23", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:01 --> fp24"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:01", NAME="fp24", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:7e --> fp25"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:7e", NAME="fp25", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:3e --> fp26"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:3e", NAME="fp26", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:56 --> fp27"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:56", NAME="fp27", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:83 --> fp28"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:83", NAME="fp28", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:08 --> fp29"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:08", NAME="fp29", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3d --> fp30"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3d", NAME="fp30", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:45 --> fp31"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:45", NAME="fp31", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc4-1 #####
  config.vm.define "chassis04-lc4-1" do |device|
    
    device.vm.hostname = "chassis04-lc4-1" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc4-1"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net607", auto_config: false , :mac => "44383900047c"
      
      # link for fp0 --> chassis04-fc1-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net187", auto_config: false , :mac => "443839000172"
      
      # link for fp1 --> chassis04-fc1-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net142", auto_config: false , :mac => "443839000118"
      
      # link for fp2 --> chassis04-fc1-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net397", auto_config: false , :mac => "443839000313"
      
      # link for fp3 --> chassis04-fc1-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net93", auto_config: false , :mac => "4438390000b6"
      
      # link for fp4 --> chassis04-fc2-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net229", auto_config: false , :mac => "4438390001c6"
      
      # link for fp5 --> chassis04-fc2-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net538", auto_config: false , :mac => "443839000428"
      
      # link for fp6 --> chassis04-fc2-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net487", auto_config: false , :mac => "4438390003c5"
      
      # link for fp7 --> chassis04-fc2-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net82", auto_config: false , :mac => "4438390000a1"
      
      # link for fp8 --> chassis04-fc3-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net300", auto_config: false , :mac => "443839000253"
      
      # link for fp9 --> chassis04-fc3-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net270", auto_config: false , :mac => "443839000218"
      
      # link for fp10 --> chassis04-fc3-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net501", auto_config: false , :mac => "4438390003e0"
      
      # link for fp11 --> chassis04-fc3-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net120", auto_config: false , :mac => "4438390000ec"
      
      # link for fp12 --> chassis04-fc4-1:fp24
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net191", auto_config: false , :mac => "44383900017a"
      
      # link for fp13 --> chassis04-fc4-1:fp25
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net177", auto_config: false , :mac => "44383900015e"
      
      # link for fp14 --> chassis04-fc4-1:fp26
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net351", auto_config: false , :mac => "4438390002b7"
      
      # link for fp15 --> chassis04-fc4-1:fp27
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net280", auto_config: false , :mac => "44383900022b"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:7c --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:7c", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:72 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:72", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:18 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:18", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:13 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:13", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:b6 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:b6", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:c6 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:c6", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:28 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:28", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c5 --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c5", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a1 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a1", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:53 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:53", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:18 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:18", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:e0 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:e0", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:ec --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:ec", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:7a --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:7a", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:5e --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:5e", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:b7 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:b7", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:2b --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:2b", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis04-lc4-2 #####
  config.vm.define "chassis04-lc4-2" do |device|
    
    device.vm.hostname = "chassis04-lc4-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis04-lc4-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net608", auto_config: false , :mac => "44383900047d"
      
      # link for fp0 --> chassis04-fc1-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net74", auto_config: false , :mac => "443839000091"
      
      # link for fp1 --> chassis04-fc1-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net138", auto_config: false , :mac => "443839000110"
      
      # link for fp2 --> chassis04-fc1-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net144", auto_config: false , :mac => "44383900011c"
      
      # link for fp3 --> chassis04-fc1-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net489", auto_config: false , :mac => "4438390003c9"
      
      # link for fp4 --> chassis04-fc2-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net40", auto_config: false , :mac => "44383900004e"
      
      # link for fp5 --> chassis04-fc2-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net429", auto_config: false , :mac => "443839000352"
      
      # link for fp6 --> chassis04-fc2-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net548", auto_config: false , :mac => "44383900043c"
      
      # link for fp7 --> chassis04-fc2-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net527", auto_config: false , :mac => "443839000413"
      
      # link for fp8 --> chassis04-fc3-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net11", auto_config: false , :mac => "443839000015"
      
      # link for fp9 --> chassis04-fc3-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net344", auto_config: false , :mac => "4438390002a9"
      
      # link for fp10 --> chassis04-fc3-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net543", auto_config: false , :mac => "443839000432"
      
      # link for fp11 --> chassis04-fc3-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net214", auto_config: false , :mac => "4438390001a8"
      
      # link for fp12 --> chassis04-fc4-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net367", auto_config: false , :mac => "4438390002d7"
      
      # link for fp13 --> chassis04-fc4-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net220", auto_config: false , :mac => "4438390001b4"
      
      # link for fp14 --> chassis04-fc4-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net10", auto_config: false , :mac => "443839000013"
      
      # link for fp15 --> chassis04-fc4-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net143", auto_config: false , :mac => "44383900011a"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:7d --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:7d", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:91 --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:91", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:10 --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:10", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1c --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1c", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:c9 --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:c9", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4e --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4e", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:52 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:52", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:3c --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:3c", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:13 --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:13", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:15 --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:15", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:a9 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:a9", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:32 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:32", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:a8 --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:a8", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:d7 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:d7", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:b4 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:b4", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:13 --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:13", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:1a --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:1a", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for chassis03-lc4-2 #####
  config.vm.define "chassis03-lc4-2" do |device|
    
    device.vm.hostname = "chassis03-lc4-2" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_chassis03-lc4-2"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net609", auto_config: false , :mac => "44383900047e"
      
      # link for fp0 --> chassis03-fc1-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net159", auto_config: false , :mac => "44383900013a"
      
      # link for fp1 --> chassis03-fc1-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net272", auto_config: false , :mac => "44383900021c"
      
      # link for fp2 --> chassis03-fc1-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net373", auto_config: false , :mac => "4438390002e3"
      
      # link for fp3 --> chassis03-fc1-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net64", auto_config: false , :mac => "44383900007d"
      
      # link for fp4 --> chassis03-fc2-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net140", auto_config: false , :mac => "443839000114"
      
      # link for fp5 --> chassis03-fc2-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net155", auto_config: false , :mac => "443839000132"
      
      # link for fp6 --> chassis03-fc2-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net379", auto_config: false , :mac => "4438390002ef"
      
      # link for fp7 --> chassis03-fc2-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net38", auto_config: false , :mac => "44383900004a"
      
      # link for fp8 --> chassis03-fc3-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net354", auto_config: false , :mac => "4438390002bd"
      
      # link for fp9 --> chassis03-fc3-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net399", auto_config: false , :mac => "443839000317"
      
      # link for fp10 --> chassis03-fc3-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net150", auto_config: false , :mac => "443839000128"
      
      # link for fp11 --> chassis03-fc3-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net15", auto_config: false , :mac => "44383900001d"
      
      # link for fp12 --> chassis03-fc4-1:fp28
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net384", auto_config: false , :mac => "4438390002f9"
      
      # link for fp13 --> chassis03-fc4-1:fp29
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net166", auto_config: false , :mac => "443839000148"
      
      # link for fp14 --> chassis03-fc4-1:fp30
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net215", auto_config: false , :mac => "4438390001aa"
      
      # link for fp15 --> chassis03-fc4-1:fp31
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net45", auto_config: false , :mac => "443839000057"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc11', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc12', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc13', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc14', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc15', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc16', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc17', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc18', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:7e --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:7e", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:3a --> fp0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:3a", NAME="fp0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:1c --> fp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:1c", NAME="fp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:e3 --> fp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:e3", NAME="fp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:7d --> fp3"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:7d", NAME="fp3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:14 --> fp4"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:14", NAME="fp4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:32 --> fp5"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:32", NAME="fp5", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:ef --> fp6"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:ef", NAME="fp6", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:4a --> fp7"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:4a", NAME="fp7", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:bd --> fp8"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:bd", NAME="fp8", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:17 --> fp9"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:17", NAME="fp9", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:28 --> fp10"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:28", NAME="fp10", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:1d --> fp11"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:1d", NAME="fp11", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:f9 --> fp12"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:f9", NAME="fp12", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:48 --> fp13"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:48", NAME="fp13", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:aa --> fp14"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:aa", NAME="fp14", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:57 --> fp15"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:57", NAME="fp15", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf06 #####
  config.vm.define "leaf06" do |device|
    
    device.vm.hostname = "leaf06" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf06"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net584", auto_config: false , :mac => "443839000465"
      
      # link for swp1 --> server05:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net86", auto_config: false , :mac => "4438390000a9"
      
      # link for swp2 --> server06:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net26", auto_config: false , :mac => "443839000033"
      
      # link for swp49 --> leaf05:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net408", auto_config: false , :mac => "44383900032a"
      
      # link for swp50 --> leaf05:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net53", auto_config: false , :mac => "443839000068"
      
      # link for swp51 --> chassis01-lc3-2:swp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net224", auto_config: false , :mac => "4438390001bc"
      
      # link for swp52 --> chassis02-lc3-2:swp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net262", auto_config: false , :mac => "443839000208"
      
      # link for swp53 --> chassis03-lc3-2:swp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net511", auto_config: false , :mac => "4438390003f3"
      
      # link for swp54 --> chassis04-lc3-2:swp6
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net449", auto_config: false , :mac => "443839000379"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:65 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:65", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:a9 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:a9", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:33 --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:33", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:2a --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:2a", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:68 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:68", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:bc --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:bc", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:08 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:08", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:f3 --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:f3", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:79 --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:79", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf04 #####
  config.vm.define "leaf04" do |device|
    
    device.vm.hostname = "leaf04" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf04"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net585", auto_config: false , :mac => "443839000466"
      
      # link for swp1 --> server03:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net303", auto_config: false , :mac => "443839000259"
      
      # link for swp2 --> server04:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net435", auto_config: false , :mac => "44383900035e"
      
      # link for swp49 --> leaf03:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net535", auto_config: false , :mac => "443839000423"
      
      # link for swp50 --> leaf03:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net274", auto_config: false , :mac => "443839000221"
      
      # link for swp51 --> chassis01-lc2-2:swp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net334", auto_config: false , :mac => "443839000295"
      
      # link for swp52 --> chassis02-lc2-2:swp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net462", auto_config: false , :mac => "443839000393"
      
      # link for swp53 --> chassis03-lc2-2:swp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net537", auto_config: false , :mac => "443839000426"
      
      # link for swp54 --> chassis04-lc2-2:swp4
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net309", auto_config: false , :mac => "443839000264"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:66 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:66", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:59 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:59", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:5e --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:5e", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:23 --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:23", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:21 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:21", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:95 --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:95", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:93 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:93", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:26 --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:26", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:64 --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:64", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf05 #####
  config.vm.define "leaf05" do |device|
    
    device.vm.hostname = "leaf05" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf05"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net586", auto_config: false , :mac => "443839000467"
      
      # link for swp1 --> server05:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net552", auto_config: false , :mac => "443839000444"
      
      # link for swp2 --> server06:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net506", auto_config: false , :mac => "4438390003ea"
      
      # link for swp49 --> leaf06:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net408", auto_config: false , :mac => "443839000329"
      
      # link for swp50 --> leaf06:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net53", auto_config: false , :mac => "443839000067"
      
      # link for swp51 --> chassis01-lc3-1:swp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net81", auto_config: false , :mac => "44383900009f"
      
      # link for swp52 --> chassis02-lc3-1:swp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net496", auto_config: false , :mac => "4438390003d7"
      
      # link for swp53 --> chassis03-lc3-1:swp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net148", auto_config: false , :mac => "443839000124"
      
      # link for swp54 --> chassis04-lc3-1:swp5
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net225", auto_config: false , :mac => "4438390001be"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:67 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:67", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:44 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:44", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:ea --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:ea", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:29 --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:29", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:67 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:67", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:9f --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:9f", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d7 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d7", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:24 --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:24", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:be --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:be", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf02 #####
  config.vm.define "leaf02" do |device|
    
    device.vm.hostname = "leaf02" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf02"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net587", auto_config: false , :mac => "443839000468"
      
      # link for swp1 --> server01:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net530", auto_config: false , :mac => "443839000419"
      
      # link for swp2 --> server02:eth2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net41", auto_config: false , :mac => "443839000050"
      
      # link for swp49 --> leaf01:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net6", auto_config: false , :mac => "44383900000c"
      
      # link for swp50 --> leaf01:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net35", auto_config: false , :mac => "443839000045"
      
      # link for swp51 --> chassis01-lc1-2:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net536", auto_config: false , :mac => "443839000424"
      
      # link for swp52 --> chassis02-lc1-2:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net21", auto_config: false , :mac => "443839000029"
      
      # link for swp53 --> chassis03-lc1-2:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net314", auto_config: false , :mac => "44383900026e"
      
      # link for swp54 --> chassis04-lc1-2:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net149", auto_config: false , :mac => "443839000126"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:68 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:68", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:19 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:19", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:50 --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:50", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0c --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0c", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:45 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:45", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:24 --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:24", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:29 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:29", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:6e --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:6e", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:26 --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:26", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf03 #####
  config.vm.define "leaf03" do |device|
    
    device.vm.hostname = "leaf03" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf03"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net588", auto_config: false , :mac => "443839000469"
      
      # link for swp1 --> server03:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net316", auto_config: false , :mac => "443839000272"
      
      # link for swp2 --> server04:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net498", auto_config: false , :mac => "4438390003db"
      
      # link for swp49 --> leaf04:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net535", auto_config: false , :mac => "443839000422"
      
      # link for swp50 --> leaf04:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net274", auto_config: false , :mac => "443839000220"
      
      # link for swp51 --> chassis01-lc2-1:swp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net464", auto_config: false , :mac => "443839000397"
      
      # link for swp52 --> chassis02-lc2-1:swp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net12", auto_config: false , :mac => "443839000017"
      
      # link for swp53 --> chassis03-lc2-1:swp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net284", auto_config: false , :mac => "443839000233"
      
      # link for swp54 --> chassis04-lc2-1:swp3
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net497", auto_config: false , :mac => "4438390003d9"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:69 --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:69", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:72 --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:72", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:db --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:db", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:22 --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:22", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:20 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:20", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:97 --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:97", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:17 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:17", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:33 --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:33", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:d9 --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:d9", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for leaf01 #####
  config.vm.define "leaf01" do |device|
    
    device.vm.hostname = "leaf01" 
    
    device.vm.box = "CumulusCommunity/cumulus-vx"
    device.vm.box_version = "3.4.3"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_leaf01"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 768
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth0 --> NOTHING:NOTHING
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net589", auto_config: false , :mac => "44383900046a"
      
      # link for swp1 --> server01:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net417", auto_config: false , :mac => "44383900033b"
      
      # link for swp2 --> server02:eth1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net277", auto_config: false , :mac => "443839000226"
      
      # link for swp49 --> leaf02:swp49
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net6", auto_config: false , :mac => "44383900000b"
      
      # link for swp50 --> leaf02:swp50
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net35", auto_config: false , :mac => "443839000044"
      
      # link for swp51 --> chassis01-lc1-1:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net154", auto_config: false , :mac => "443839000130"
      
      # link for swp52 --> chassis02-lc1-1:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net237", auto_config: false , :mac => "4438390001d6"
      
      # link for swp53 --> chassis03-lc1-1:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net515", auto_config: false , :mac => "4438390003fb"
      
      # link for swp54 --> chassis04-lc1-1:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net68", auto_config: false , :mac => "443839000085"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc4', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc5', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc6', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc7', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc8', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc9', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc10', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_switch.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:04:6a --> eth0"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:04:6a", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:3b --> swp1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:3b", NAME="swp1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:02:26 --> swp2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:02:26", NAME="swp2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:0b --> swp49"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:0b", NAME="swp49", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:44 --> swp50"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:44", NAME="swp50", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:30 --> swp51"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:30", NAME="swp51", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:01:d6 --> swp52"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:01:d6", NAME="swp52", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:03:fb --> swp53"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:03:fb", NAME="swp53", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 44:38:39:00:00:85 --> swp54"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:00:00:85", NAME="swp54", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server01 #####
  config.vm.define "server01" do |device|
    
    device.vm.hostname = "server01" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server01"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf01:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net417", auto_config: false , :mac => "000300111101"
      
      # link for eth2 --> leaf02:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net530", auto_config: false , :mac => "000300111102"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:11:11:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:11:11:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:11:11:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:11:11:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server03 #####
  config.vm.define "server03" do |device|
    
    device.vm.hostname = "server03" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server03"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf03:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net316", auto_config: false , :mac => "000300333301"
      
      # link for eth2 --> leaf04:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net303", auto_config: false , :mac => "000300333302"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:33:33:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:33:33:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:33:33:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:33:33:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server02 #####
  config.vm.define "server02" do |device|
    
    device.vm.hostname = "server02" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server02"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf01:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net277", auto_config: false , :mac => "000300222201"
      
      # link for eth2 --> leaf02:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net41", auto_config: false , :mac => "000300222202"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:22:22:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:22:22:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:22:22:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:22:22:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server05 #####
  config.vm.define "server05" do |device|
    
    device.vm.hostname = "server05" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server05"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf05:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net552", auto_config: false , :mac => "000300555501"
      
      # link for eth2 --> leaf06:swp1
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net86", auto_config: false , :mac => "000300555502"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:55:55:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:55:55:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:55:55:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:55:55:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server06 #####
  config.vm.define "server06" do |device|
    
    device.vm.hostname = "server06" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server06"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf05:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net506", auto_config: false , :mac => "000300666601"
      
      # link for eth2 --> leaf06:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net26", auto_config: false , :mac => "000300666602"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:66:66:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:66:66:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:66:66:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:66:66:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end

  ##### DEFINE VM for server04 #####
  config.vm.define "server04" do |device|
    
    device.vm.hostname = "server04" 
    
    device.vm.box = "yk0/ubuntu-xenial"
    device.vm.provider "virtualbox" do |v|
      v.name = "#{simid}_server04"
      v.customize ["modifyvm", :id, '--audiocontroller', 'AC97', '--audio', 'Null']
      v.memory = 512
    end
    #   see note here: https://github.com/pradels/vagrant-libvirt#synced-folders
    device.vm.synced_folder ".", "/vagrant", disabled: true



    # NETWORK INTERFACES
      # link for eth1 --> leaf03:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net498", auto_config: false , :mac => "000300444401"
      
      # link for eth2 --> leaf04:swp2
      device.vm.network "private_network", virtualbox__intnet: "#{simid}_net435", auto_config: false , :mac => "000300444402"
      

    device.vm.provider "virtualbox" do |vbox|
      vbox.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
      vbox.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
      vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]
    end

    # Fixes "stdin: is not a tty" and "mesg: ttyname failed : Inappropriate ioctl for device"  messages --> https://github.com/mitchellh/vagrant/issues/1673
    device.vm.provision :shell , inline: "(sudo grep -q 'mesg n' /root/.profile 2>/dev/null && sudo sed -i '/mesg n/d' /root/.profile  2>/dev/null) || true;", privileged: false

    # Shorten Boot Process - Applies to Ubuntu Only - remove \"Wait for Network\"
    device.vm.provision :shell , inline: "sed -i 's/sleep [0-9]*/sleep 1/' /etc/init/failsafe.conf 2>/dev/null || true"

    
    # Run the Config specified in the Node Attributes
    device.vm.provision :shell , privileged: false, :inline => 'echo "$(whoami)" > /tmp/normal_user'
    device.vm.provision :shell , path: "./helper_scripts/config_server.sh"


    # Install Rules for the interface re-map
    device.vm.provision :shell , :inline => <<-delete_udev_directory
if [ -d "/etc/udev/rules.d/70-persistent-net.rules" ]; then
    rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
fi
rm -rfv /etc/udev/rules.d/70-persistent-net.rules &> /dev/null
delete_udev_directory

device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:44:44:01 --> eth1"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:44:44:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     device.vm.provision :shell , :inline => <<-udev_rule
echo "  INFO: Adding UDEV Rule: 00:03:00:44:44:02 --> eth2"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="00:03:00:44:44:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
udev_rule
     
      device.vm.provision :shell , :inline => <<-vagrant_interface_rule
echo "  INFO: Adding UDEV Rule: Vagrant interface = vagrant"
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules
echo "#### UDEV Rules (/etc/udev/rules.d/70-persistent-net.rules) ####"
cat /etc/udev/rules.d/70-persistent-net.rules
vagrant_interface_rule

# Run Any Platform Specific Code and Apply the interface Re-map
    #   (may or may not perform a reboot depending on platform)
    device.vm.provision :shell , :inline => $script

end



end