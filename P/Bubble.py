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
    # Sort processes based on priority using Bubble Sort
    n = len(processes)
    for i in range(n - 1):
        for j in range(0, n - i - 1):
            if processes[j].priority > processes[j + 1].priority:
                processes[j], processes[j + 1] = processes[j + 1], processes[j]

    current_time = 0
    total_waiting_time = 0
    total_turnaround_time = 0
    
    print()
    print("Process\tArrival Time\tBurst Time\tPriority\tWaiting Time\tTurnaround Time\tCompletion Time")

    for process in processes:
        process.waiting_time = max(0, current_time - process.arrival_time)
        process.turnaround_time = process.burst_time + process.waiting_time
        current_time += process.burst_time

        # Using the formula WT = TAT - BT
        process.waiting_time = process.turnaround_time - process.burst_time
        process.completion_time = current_time

        total_waiting_time += process.waiting_time
        total_turnaround_time += process.turnaround_time

        print(
            f"{process.name}\t{process.arrival_time}\t\t{process.burst_time}\t\t{process.priority}\t\t{process.waiting_time}\t\t{process.turnaround_time}\t\t{process.completion_time}"
        )

    avg_waiting_time = total_waiting_time / len(processes)
    avg_turnaround_time = total_turnaround_time / len(processes)

    print("\nAverage Waiting Time:", avg_waiting_time)
    print("Average Turnaround Time:", avg_turnaround_time)


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
