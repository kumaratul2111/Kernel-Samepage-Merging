#!/bin/bash

sudo chmod 666 /sys/kernel/mm/ksm/pages_to_scan
sudo chmod 666 /sys/kernel/mm/ksm/run
sudo chmod 666 /sys/kernel/mm/ksm/sleep_millisecs
sudo chmod 666 /sys/kernel/mm/ksm/max_page_sharing

echo 5000 > /sys/kernel/mm/ksm/pages_to_scan
echo 10 > /sys/kernel/mm/ksm/sleep_millisecs
echo $1 > /sys/kernel/mm/ksm/max_page_sharing
echo 1 > /sys/kernel/mm/ksm/run

echo -n -e "\033[32mFull scans\tpages shared\tpages sharing\tpages unshared\tpages volatile\tgeneral profit\033[0m\n" >> one_vm_max_page_sharing_$1.txt
echo -n -e "\033[32mFull scans\tpages shared\tpages sharing\tpages unshared\tpages volatile\tgeneral profit\033[0m\n" 
while true
do
	pages_shared=$(cat /sys/kernel/mm/ksm/pages_shared)
	pages_sharing=$(cat /sys/kernel/mm/ksm/pages_sharing)
	pages_unshared=$(cat /sys/kernel/mm/ksm/pages_unshared)
	pages_volatile=$(cat /sys/kernel/mm/ksm/pages_volatile)
	general_profit=$(cat /sys/kernel/mm/ksm/general_profit)
	full_scans=$(cat /sys/kernel/mm/ksm/full_scans)
	echo -n -e "$full_scans\t\t$pages_shared\t\t$pages_sharing\t\t$pages_unshared\t\t$pages_volatile\t\t$general_profit\n" >> one_vm_max_page_sharing_$1.txt
	echo -n -e "$full_scans\t\t$pages_shared\t\t$pages_sharing\t\t$pages_unshared\t\t$pages_volatile\t\t$general_profit\n"
	sleep 5
done
