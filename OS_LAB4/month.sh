#!/bin/bash

# Check if a parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <month_number>"
    exit 1
fi

# Get the month number from the command line argument
month_number=$1

# Use case statement to display the corresponding month
case $month_number in
    1)
        echo "January"
        ;;
    2)
        echo "February"
        ;;
    3)
        echo "March"
        ;;
    *)
        echo "Invalid month number. Please enter a number from 1 to 3."
        ;;
esac
