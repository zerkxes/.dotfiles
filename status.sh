#! /bin/bash

stat() {
	DATE_TIME=$(date +"%a %d | %T");
	BATT=$(cat /sys/class/power_supply/BAT0/capacity)%;
	MEM=$(free -m | awk 'FNR == 2 {print $2,$3,$4,$5,$6,$7; exit'});
	MEM_TOTAL=$(echo $MEM | awk '{print $1}');
	MEM_SHARED=$(echo $MEM | awk '{print $4}');
	MEM_CACHE=$(echo $MEM | awk '{print $5}');
	MEM_FREE=$(echo $MEM | awk '{print $3}');
	RAM=$((MEM_TOTAL+MEM_SHARED-MEM_CACHE-MEM_FREE))Mb;
	VOL=$(awk -F "[][]" '/Left:/ {print $2}' <(amixer sget Master));
	echo "Vol: $VOL | Mem: $RAM | Batt: $BATT | $DATE_TIME";
}

while true; do
  cpu_now=($(head -n1 /proc/stat)) 
  cpu_sum="${cpu_now[@]:1}" 
  cpu_sum=$((${cpu_sum// /+})) 
  cpu_delta=$((cpu_sum - cpu_last_sum)) 
  cpu_idle=$((cpu_now[4]- cpu_last[4])) 
  cpu_used=$((cpu_delta - cpu_idle)) 
  cpu_usage=$((100 * cpu_used / cpu_delta))  
  cpu_last=("${cpu_now[@]}") 
  cpu_last_sum=$cpu_sum 
	xsetroot -name "CPU: $cpu_usage% | $(stat)";
	sleep 5s;
done
exit
