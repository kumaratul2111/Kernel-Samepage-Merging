#!/bin/bash

while true
do
	available=$(cat /proc/meminfo | grep Available)
	free=$(cat /proc/meminfo | grep MemFree)
	anonpages=$(cat /proc/meminfo | grep AnonPages)
	anon=$(cat /proc/meminfo | grep "Active(anon)")
	echo -n -e "$available\t\t" >> memory_output_with_ksm_5.txt
	echo -ne "$free\t\t" >> memory_output_with_ksm_5.txt
	echo -ne "$anonpages\t\t" >> memory_output_with_ksm_5.txt
	echo -ne "$anon\n" >> memory_output_with_ksm_5.txt
	echo -n -e "$available\t\t"
	echo -ne "$free\t\t"
	echo -ne "$anonpages\t\t"
	echo -ne "$anon\n"
	sleep 30
done
