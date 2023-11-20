# The following bash commands are for setting up mDNS on a series of machines
# with distinct hostnames. This is useful for setting up a cluster of machines
# that can be accessed by hostname.local instead of IP address. We will also
# enable ssh access if the firewall is running. Once you've gone through this
# list on each machine, we can run ssh-copy-id to copy the ssh key to each
# machine and then ssh to each machine by hostname.local instead of IP address.

# update package list
sudo apt-get update

# install packages
sudo apt-get install rsync avahi-daemon

# check the hostname and make sure it is distinct. Write it down.
hostnamectl status
#If the hostname isn't distinct, set a new hostname and write it down along with
#a description so you can easily identify it.
sudo hostnamectl set-hostname NEWMACHINENAME

# check if avahi is installed and running for mDNS. It should be. If not notify
# your admin.
systemctl status avahi-daemon

# check if ufw is installed and running. If not, leave it off and reboot.
sudo ufw status

# If firewall is active from last step, allow ssh and mDNS then reload ufw
sudo ufw allow ssh
sudo ufw allow 5353/udp
sudo ufw reload