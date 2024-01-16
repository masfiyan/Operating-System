#!/bin/bash

# Function to display the name of the week day
display_weekday() {
    day_number=$1

    case $day_number in
        1) echo "Sunday" ;;
        2) echo "Monday" ;;
        3) echo "Tuesday" ;;
        4) echo "Wednesday" ;;
        5) echo "Thursday" ;;
        6) echo "Friday" ;;
        7) echo "Saturday" ;;
        *)
            echo "Error: Invalid day number. Please enter a number between 1 and 7."
            ;;
    esac
}

# Check if a day number is provided as a command-line argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <day_number>"
    exit 1
fi

# Call the function with the provided day number
display_weekday "$1"
