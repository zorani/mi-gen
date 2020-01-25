#!/bin/bash -e

#SETUP SSH

mkdir -p /home/pi/.ssh
cd /home/pi/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcC2Midr8eQIHvXC4XIaLogFQxoSahAvv7aoxmpZV1QTf60Q/l69+Q68ilhrHxlKU7AB7/jIU1EjZnyjWkqSePwI4UKMCeFM0uMUo1l3s1NfcC3aa3VbxYoxuKJBHu2AhxNVSh03OR8EePKtDsIs79Ug93PbSgUfrfmCnrwtr2ZPSTjgoUhQci9P0Jni7tb4P6WDJ/NkFCGqe6LxXOWbNDKC6yyf07uC64Up/sMYmaxkadOR/GtWCIMPtD38KPb9IYQy6xZkbKzvrpi2NEjkWlueNvEKiXMRAHARKwq6j2xi/azWW4GvG/FZ9lWDj4fR5ciCY6mHUUgv3vsUrzRofl test" > authorized_keys
echo "" >> authorized_keys

on_chroot << EOF

sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config
sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
sed -i '/#PasswordAuthentication/s/.*/PasswordAuthentication no/' /etc/ssh/sshd_config

systemctl enable ssh
systemctl start ssh

EOF



#SETUP WIFI

on_chroot << EOG

sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null <<EOH

network={
	ssid="ZyXEL93025_5G"
	psk=73880f2c41df6f2110ac4cc6481975d9c31a59bd08b0621cce2441c6b71f9ac0
}
EOH

#wpa_cli -i wlan0 reconfigure

EOG
