#!/bin/bash

# Check if both age and marks are provided as command-line arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <age> <marks>"
    exit 1
fi

# Extract age and marks from command-line arguments
age=$1
marks=$2

# Check eligibility criteria
if [ "$age" -lt 18 ] && [ "$marks" -gt 700 ]; then
    echo "Eligible for admission."
else
    echo "Not eligible for admission."
fi
