class Process:
    def __init__(self, name, arrival_time, burst_time, priority):
        self.name = name
        self.arrival_time = arrival_time
        self.burst_time = burst_time
        self.priority = priority
        self.waiting_time = 0
        self.turnaround_time = 0
        self.completion_time = 0


def priority_scheduling(processes):
    # Sort processes based on priority
    processes.sort(key=lambda x: x.priority)

    current_time = 0

    print("Process\tArrival Time\tBurst Time\tPriority\tWaiting Time\tTurnaround Time\tCompletion Time")

    for process in processes:
        process.waiting_time = max(0, current_time - process.arrival_time)
        process.turnaround_time = process.burst_time + process.waiting_time
        current_time += process.burst_time

        # Using the formula WT = TAT - BT
        process.waiting_time = process.turnaround_time - process.burst_time
        process.completion_time = current_time

        print(
            f"{process.name}\t{process.arrival_time}\t\t{process.burst_time}\t\t{process.priority}\t\t{process.waiting_time}\t\t{process.turnaround_time}\t\t{process.completion_time}"
        )


if __name__ == "__main__":
    # Take input for the number of processes
    num_processes = int(input("Enter the number of processes: "))

    # Take input for each process
    processes = []
    for i in range(1, num_processes + 1):
        name = f"P{i}"
        arrival_time = int(input(f"Enter arrival time for {name}: "))
        burst_time = int(input(f"Enter burst time for {name}: "))
        priority = int(input(f"Enter priority for {name}: "))
        processes.append(Process(name, arrival_time, burst_time, priority))

    priority_scheduling(processes)
