#!/bin/bash

## The space you want left
left=1000M 
## The unit you are using (Units are K, M, G,  T,  P, E, Z, Y (powers of 1024) or 
## KB, MB, ... (powers of 1000).
unit=G
## The target drive
disk=/dev/nvme0n1p1
## The file name to create, make sure it is on the right drive.
outfile=fullfill.txt
## The space currently available on the target drive
avail=$(df --output=source,avail -B$unit | grep $disk | awk '{print $NF}' | sed s/$unit//i); 
## The size of the file to be created
size=$((avail-left))
## Skip if the available free space is already less than what requested
if [ "$size" -gt 0 ]; then
## Use fallocate if possible, fall back to head otherwise
fallocate -l $size$unit $outfile 2>/dev/null || head -c $size$unit /dev/zero > $outfile
else 
echo "There is already less then $left space available on $disk"
fi


#create file for fill up hdd
fallocate -l 440G fullfill.txt
