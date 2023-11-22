#!/bin/bash
# This Bash script reads a list of clients from 'client_list.txt', where each
# line contains hostname, username, and directory separated by commas. It uses
# the information to perform an rsync operation, synchronizing files from the
# specified remote server to a local directory. A log file is generated for each
# operation with a naming format 'rsync-HOSTNAME-YYYY-MM-DD.log'.

# Usage: Ensure 'client_list.txt' is properly formatted, run the script, and
# observe rsync operations and logs. The script is in dry-run mode by default,
# so no files will be transferred. To perform actual rsync operations, remove
# the '-n' flag from the rsync command.

destination="/home/swamylab/mouselab/data"

while read -r line; do
    hostname=$(echo $line | cut -d ',' -f 1)
    username=$(echo $line | cut -d ',' -f 2)
    directory=$(echo $line | cut -d ',' -f 3)
    log_file="rsync-$hostname-$(date +%Y-%m-%d).log"
    command="rsync -av --ignore-existing --log-file=$log_file $username@$hostname:$directory $destination/$hostname"
    echo "running: $command"
    $command
done < client_list.txt
