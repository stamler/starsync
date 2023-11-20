#!/bin/bash
# This script iterates through the entries in client_list.txt in which each line
# is three columns separated by a comma. The first item is a hostname the second
# item is a username, the third item is an absolute directory path. The script 

# reads each line from the client_list.txt file. The 3 columns are hostname,
# username, and absolute directory path. These client machines are the rsync
# source. The destination is the /home/LOCALUSER/repository directory on the
# local machine. The script uses the rsync command over ssh to copy the files.
# We use the archive and ignore-existing options. The archive option preserves
# the permissions, ownership, and timestamps of the files. The ignore-existing
# option prevents overwriting files that already exist in the destination. We
# will write the rsync output to a log file which includes the hostname and
# date. The log file will be in the same directory as the script.

while read -r line; do
    hostname=$(echo $line | cut -d ',' -f 1)
    username=$(echo $line | cut -d ',' -f 2)
    directory=$(echo $line | cut -d ',' -f 3)
    log_file="rsync-$hostname-$(date +%Y-%m-%d).log"
    rsync -av --ignore-existing --log-file=$log_file $username@$hostname:$directory /home/LOCALUSER/repository/$hostname
done < client_list.txt

