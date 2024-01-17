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
    # Selection Sort processes based on priority
    n = len(processes)
    for i in range(n - 1):
        min_index = i
        for j in range(i + 1, n):
            if processes[j].priority < processes[min_index].priority:
                min_index = j

        processes[i], processes[min_index] = processes[min_index], processes[i]

    current_time = 0
    total_waiting_time = 0
    total_turnaround_time = 0

    print("Selection Sort (Priority Scheduling) Process Table:")
    print("------------------------------------------------------------------")
    print("| Process | Arrival Time | Burst Time | Priority | Waiting Time | Turnaround Time | Completion Time |")
    print("------------------------------------------------------------------")
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
            f"| {process.name:8} | {process.arrival_time:12} | {process.burst_time:10} | {process.priority:8} | {process.waiting_time:13} | {process.turnaround_time:16} | {process.completion_time:16} |"
        )
    print("------------------------------------------------------------------")

    avg_waiting_time = total_waiting_time / len(processes)
    avg_turnaround_time = total_turnaround_time / len(processes)

    print("\nAverage Waiting Time (Selection Sort - Priority Scheduling):", avg_waiting_time)
    print("Average Turnaround Time (Selection Sort - Priority Scheduling):", avg_turnaround_time)


if __name__ == "__main__":
    # Take input for the number of processes
    num_processes = int(input("Enter the number of processes: "))

    # Take input for each process
    processes_selection = []
    for i in range(1, num_processes + 1):
        name = f"P{i}"
        arrival_time = int(input(f"Enter arrival time for {name}: "))
        burst_time = int(input(f"Enter burst time for {name}: "))
        priority = int(input(f"Enter priority for {name}: "))
        processes_selection.append(Process(name, arrival_time, burst_time, priority))

    priority_scheduling(processes_selection)
