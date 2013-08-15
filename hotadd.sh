#!/bin/bash

MEM=$(grep offline /sys/devices/system/memory/memory*/state); 	#sets MEM as only those in offline state					
if [ $(grep offline /sys/devices/system/memory/memory*/state | wc -l) -eq 0 ]; 	#counts number of lines returned 
	then 
		echo "All memory online";	#if all is online ends and just outputs current memory usage
	else 
		echo "There are $(echo "$MEM" | wc -l) modules offline:";	#echo's number of offline modules
		echo "$MEM"| awk -F '/' '{print $6}';	#sets field marker as / and brings back the second field (memory1/2/3/etc)
		echo "Bringing memory online"; 			
		for x in $(grep offline /sys/devices/system/memory/memory*/state |awk -F ':' '{print $1}');  
			do echo "online" > $x ; #writes to /memory*/state online
		done; 
		echo "Memory online:"; cd 
		dmesg | tail -1; #if memory has been brought online it will also bring back any messages in case something went wrong
	fi; 
free -m; # memory usage will always be reported whether memory has been brought online or not
