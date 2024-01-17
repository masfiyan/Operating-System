#!/bin/bash

# Check if at least two parameters are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <number1> <number2> [<number3> ...]"
    exit 1
fi

# Initialize sum to 0
sum=0

# Loop through all the parameters and add them to the sum
for num in "$@"; do
    echo $num
    sum=$((sum + num))
done

# Display the result
echo "Sum: $sum"
