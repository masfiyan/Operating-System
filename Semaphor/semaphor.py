import threading 
import random
import time

buf = []
empty = threading.Semaphore(5)
full = threading.Semaphore(0)
mutex = threading.Lock()

def producer():
    nums = range(5)
    global buf
    num = random.choice(nums)
    empty.acquire()
    mutex.acquire()
    # added
    buf.append(num)
    print("Produced", num, buf)
    mutex.release()
    # added
    full.release()
    time.sleep(1)

def consumer():
    global buf
    full.acquire()
    mutex.acquire()
    # added
    num = buf.pop(0)
    print("Consumed", num, buf)
    mutex.release()
    # added
    empty.release()
    time.sleep(2)

producerThread1 = threading.Thread(target=producer)
producerThread2 = threading.Thread(target=producer)
consumerThread1 = threading.Thread(target=consumer)
consumerThread2 = threading.Thread(target=consumer)

consumerThread1.start()
consumerThread2.start()
producerThread1.start()
producerThread2.start()
