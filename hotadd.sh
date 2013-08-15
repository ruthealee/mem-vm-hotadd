#!/bin/bash

MEM=$(grep offline ./memory*/state); if [ $(grep offline ./memory*/state | wc -l) -eq 0 ]; then echo "All memory online"; else echo "There are $(echo "$MEM" | wc -l) modules offline:"; echo "$MEM"| awk -F '/' '{print $2}'; fi; echo "Bringing memory online"; for x in $(grep offline ./memory*/state|awk -F ':' '{print $2}'); do echo "online" > $x ;done; echo "Memory online:"; free -m;
