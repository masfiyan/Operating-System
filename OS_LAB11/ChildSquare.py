import os

def child_process(w):
    for i in range(1, 6):
        square = i ** 2
        os.write(w, str(square).encode())
        os.write(w, b'\n')  # Add a newline for better separation

def parent_process(r):
    data = os.fdopen(r).readlines()
    print("Received data from the child process:")
    for line in data:
        print(line.strip())

def main():
    r, w = os.pipe()
    pid = os.fork()

    if pid > 0:
        # Parent process
        os.close(w)
        parent_process(r)
    else:
        # Child process
        os.close(r)
        child_process(w)

if __name__ == "__main__":
    main()
