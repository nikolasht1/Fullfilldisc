#!/bin/bash
disk=/dev/nvme0n1p1
unit=G
avail=$(df --output=source,avail -B$unit | grep $disk | awk '{print $NF}' | sed s/$unit//i)

if [ "$avail" -le 80 ]; then
docker rm -vf $(docker ps -aq) && docker volume prune -f
else
echo "Your $disk have ${avail}GiB of available space!"
fi
