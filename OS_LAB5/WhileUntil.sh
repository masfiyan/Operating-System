# Check if at least one parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <param1> [<param2> ...]"
    exit 1
fi

echo "While Loop"

# Using while loop to iterate through the parameters
count=1
while [ $count -le $# ]; do
    echo "Parameter $count: $1"
    shift
    count=$((count + 1))
done

echo "Until Loop"

# Using until loop to iterate through the parameters
count1=1
until [ $count1 -gt $# ]; do
    echo "Parameter $count1: $1"
    shift
    count1=$((count1 + 1))
done

