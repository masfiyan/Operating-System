import multiprocessing
import random

def calculate_square(numbers, results, start_index, end_index):
    for i in range(start_index, end_index):
        results[i] = numbers[i] ** 2

if __name__ == "__main__":
    # Generate 10 random numbers between 0 and 10
    numbers = [random.randint(0, 10) for _ in range(10)]

    # Create a shared array to store the square results
    results = multiprocessing.Array('i', len(numbers))

    # Create two processes, each handling a subset of the numbers
    process1 = multiprocessing.Process(target=calculate_square, args=(numbers, results, 0, 5))
    process2 = multiprocessing.Process(target=calculate_square, args=(numbers, results, 5, 10))

    # Start the processes
    process1.start()
    process2.start()

    # Wait for both processes to finish
    process1.join()
    process2.join()

    # Display the original numbers and the squared results
    print("Original Numbers:", numbers)
    print("Square Results:", list(results))
