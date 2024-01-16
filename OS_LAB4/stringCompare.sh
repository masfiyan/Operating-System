#!/bin/bash

# Prompt the user to enter the first string
echo "Enter the first string:"
read var1

# Prompt the user to enter the second string
echo "Enter the second string:"
read var2

# Compare the strings
if [ "$var1" = "$var2" ]; then
    echo "Strings are equal."
elif [ "$var1" < "$var2" ]; then
    echo "First string is less than the second string."
else
    echo "First string is greater than the second string."
fi

