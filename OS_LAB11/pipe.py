import os

r, w = os.pipe()
pid = os.fork()

if pid > 0:
    os.close(r)
    print("Parent process is writing")
    text = "Hello child process"
    os.write(w, text.encode())  # Ensure text is encoded before writing
else:
    os.close(w)
    # Read the text written by the parent process
    print("\nChild Process is reading")
    r = os.fdopen(r)
    print("Read text:", r.read())

