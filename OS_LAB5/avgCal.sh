#!/bin/bash

# Replace "YOUR_ROLL_NUMBER" with your actual roll number
roll_number=111

# Calculate the average of even numbers less than or equal to the roll number
sum=0
count=0

for i in $(seq 2 2 $roll_number); do
	echo $i
    sum=$((sum + i))
    count=$((count + 1))
done

# Check if there are even numbers less than or equal to the roll number
if [ $count -eq 0 ]; then
    echo "No even numbers found for the given roll number."
else
    average=$((sum / count))
    echo "Average of even numbers less than or equal to $roll_number: $average"
fi
