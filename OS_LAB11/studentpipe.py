import os
import sys

# Get your name as user input
your_name = input("Enter your name: ")

# Create a pipe
r, w = os.pipe()

# Fork the process
pid = os.fork()

if pid > 0:
    # Parent process
    os.close(r)
    print("Parent process is writing")

    # Pass your name as a command-line argument to the child process
    os.write(w, your_name.encode())

else:
    # Child process
    os.close(w)
    
    # Read your name from the parent process
    name_from_parent = os.fdopen(r).read()

    # Concatenate your name with roll number and department
    roll_number = "12345"  # Replace with your actual roll number
    department = "Computer Science"  # Replace with your actual department
    result = f"{name_from_parent} - Roll Number: {roll_number}, Department: {department}"

    print("\nChild Process is reading")
    print("Result:", result)
