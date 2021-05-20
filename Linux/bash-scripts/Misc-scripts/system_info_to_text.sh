 #!/usr/bin/env bash
#script prints free memory on the system and saves the readout
free -h > ~/backups/freemem/free_mem.txt

#prints disk usage & saves the readout
du -h > ~/backups/diskuse/disk_usage.txt

#pulls report of all open files and saves it
lsof > ~/backups/openlist/open_list.txt

#prints disk space stats and saves the readout
df -h > ~/backups/freedisk/free_disk.txt
