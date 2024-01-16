import multiprocessing

def target_function(shared_value):
    for _ in range(1000000):  # Increment the shared value multiple times
        shared_value.value += 1

if __name__ == "__main__":
    # Create a shared Value object
    shared_value = multiprocessing.Value('i', 0)

    # Create five processes, each updating the shared Value object
    processes = [multiprocessing.Process(target=target_function, args=(shared_value,)) for _ in range(5)]

    # Start the processes
    for process in processes:
        process.start()

    # Wait for all processes to finish
    for process in processes:
        process.join()

    # Display the final value
    print("Final Value:", shared_value.value)
