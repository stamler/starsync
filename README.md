# starsync

Rsync files to a central computer preserving what was already previously copied.
This repo was written for Krishnaswamy lab at McGill University.

## Setup

1. Follow the [instructions in setup_base.md](setup_base.md) to confirm each machine's
   dependencies and produce a `client_list.txt` file.

2. Run setup_ssh.bash on the central computer from a directory that also contains the
   `client_list.txt` file created in step 1.

3. Configure an rsync services on the central computer using the template in
   `rsync.bash` and schedule that service to run on a regular schedule.
