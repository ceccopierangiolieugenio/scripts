import queue
import threading
import time

# Class
class MultiThread(threading.Thread):
    def __init__(self, name):
        threading.Thread.__init__(self)
        self.name = name

    def run(self):
        print(f"Output \n ** Starting the thread - {self.name}")
        process_queue()
        print(f" ** Completed the thread - {self.name}")

# Process thr queue
def process_queue():
    while True:
        try:
            value = my_queue.get(block=False)
        except queue.Empty:
            return
        else:
            print_multiply(value)
        time.sleep(2)

# function to multiply
def print_multiply(x):
    output_value = []
    for i in range(1, x + 1):
        output_value.append(i * x)
    print(f" \n *** The multiplication result for the {x} is - {output_value}")

# Input variables
input_values = [2, 4, 6, 5,10,3]

# fill the queue
my_queue = queue.Queue()

for x in input_values:
    my_queue.put(x)

# initializing and starting 3 threads
thread1 = MultiThread('First')
thread2 = MultiThread('Second')
thread3 = MultiThread('Third')
thread4 = MultiThread('Fourth')

# Start the threads
thread1.start()
thread2.start()
thread3.start()
thread4.start()

# Join the threads
thread1.join()
thread2.join()
thread3.join()
thread4.join()
