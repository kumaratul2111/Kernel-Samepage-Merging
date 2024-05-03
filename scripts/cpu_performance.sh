#!/bin/bash

./one
echo 0 > /sys/kernel/mm/ksm/run
./one | tee -a counter.txt

original_one=$(cut -f1 counter.txt)
echo $original_one
original_two=$(cut -f2 counter.txt)
echo $original_two
original_three=$(cut -f3 counter.txt)
echo $original_three
original_four=$(cut -f4 counter.txt)
echo $original_four
original_five=$(cut -f5 counter.txt)
echo $original_five

echo "KSM ENABLED" >> counter.txt

echo 1 > /sys/kernel/mm/ksm/run
sleep 2
for i in {1..150};
do
    echo $i
    num=$(($i*1000))
    echo $num > /sys/kernel/mm/ksm/pages_to_scan
    a=$(./one)
    echo $a | tee -a counter.txt
    original_one_new=$(echo $a | cut -d ' ' -f1)
    echo $original_one_new
    original_two_new=$(echo $a | cut -d ' ' -f2)
    echo $original_two_new
    original_three_new=$(echo $a | cut -d ' ' -f3)
    echo $original_three_new
    original_four_new=$(echo $a | cut -d ' ' -f4)
    echo $original_four_new
    original_five_new=$(echo $a | cut -d ' ' -f5)
    echo $original_five_new
    diff1=$(($original_one-$original_one_new))
    diff2=$(($original_two-$original_two_new))
    diff3=$(($original_three-$original_three_new))
    diff4=$(($original_four-$original_four_new))
    diff5=$(($original_five-$original_five_new))
    echo -n -e "$diff1\t" >> difference.txt
    echo -n -e "$diff2\t" >> difference.txt
    echo -n -e "$diff3\t" >> difference.txt
    echo -n -e "$diff4\t" >> difference.txt
    echo -n -e "$diff5\t" >> difference.txt
    sum=$(($diff1+$diff2+$diff3+$diff4+$diff5))
    echo $sum
    avg=$(($sum/5))
    echo $avg
    echo -n -e "$avg\n" >> difference.txt
done
