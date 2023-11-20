# The following bash commands are for setting up mDNS on a series of machines
# with distinct hostnames. This is useful for setting up a cluster of machines
# that can be accessed by hostname.local instead of IP address. We will also
# enable ssh access if the firewall is running. Once you've gone through this
# list on each machine, we can run ssh-copy-id to copy the ssh key to each
# machine and then ssh to each machine by hostname.local instead of IP address.

# Step 1
# update package list
sudo apt-get update

# Step 2
# install packages
sudo apt-get install rsync avahi-daemon

# Step 3
# check the hostname and make sure it is distinct. Write it down in
# client_list.txt in the first column.
hostnamectl status

# IF the hostname isn't distinct, set a new hostname and write it down in
# client_list.txt in the first column.
sudo hostnamectl set-hostname NEWMACHINENAME

# Do this manually. Write down the username of the machine in the second column
# of client_list.txt. The columns should be separated only by a comma.

# Do this manually. Write down the absolute directory path that is to be backed
# up in the third column of client_list.txt. The columns should be separated
# only by a comma. This directory should end with a '/', only the contents will
# be backed up.

# Step 4
# check if avahi is installed and running for mDNS. It should be. If not notify
# your admin.
systemctl status avahi-daemon

# Step 5
# check if ufw is installed and running. If not, leave it off and reboot.
sudo ufw status

# If firewall is active from last step, allow ssh and mDNS then reload ufw
sudo ufw allow ssh
sudo ufw allow 5353/udp
sudo ufw reload