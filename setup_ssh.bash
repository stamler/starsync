# SSH setup This script is run on the "server" machine which will consolidate
# all of the rsync backups and act as the universal destination. We will be
# setting up ssh to all of the clients so that we can run rsync over ssh. This
# is a one time setup.

# First check whether there is already an ssh key on the server. If there is,
# echo that we'll do nothing. If there isn't, generate one.
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "No ssh key found. Generating one now."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
else
    echo "SSH key found. Doing nothing."
fi

# Now we need to copy the ssh key to all of the clients. We'll do this by
# looping through the clients and copying the key to each one. First we'll need
# a client list which will be a txt file with one client per line, then a comma,
# then the username that has access to the files. There will be a third column
# after the second comma that is an absolute directory path. hostnames will end
# in .local because we are using avahi to resolve them.

# First we'll check whether the client list exists. If it doesn't, we'll exit
# the script.
if [ ! -f client_list.txt ]; then
    echo "No client list found. Exiting."
    exit 1
fi

# Now we'll loop through the client list and copy the ssh key to each client.
# We'll use the ssh-copy-id command to do this. This command will copy the key
# to the client and add it to the authorized_keys file on the target machine. We
# will need to enter the password for each client but the username will be taken
# from the client list that we load as the second column.
while read -r line; do
    client=$(echo $line | cut -d ',' -f 1)
    username=$(echo $line | cut -d ',' -f 2)
    echo "Copying ssh key to $client"
    ssh-copy-id -i ~/.ssh/id_rsa.pub $username@$client
done < client_list.txt