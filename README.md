# starsync

Rsync files to a central computer preserving what was already previously copied.

## Setup

1. Manually run each command in `setup_base.bash`, reading each line and
   following the instructions in the commends and recording the necessary info into
   a `client_list.txt` file.

2. Run setup_ssh on the central computer from a directory that also contains the
   `client_list.txt` file created in step 1.

3. Configure an rsync services on the central computer using the template in
   `rsync.bash` and schedule that service to run on a regular schedule.
