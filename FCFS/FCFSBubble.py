def fcfs(processes, burst_times, arrival_times):
    n = len(processes)

    # Bubble Sort to sort processes based on arrival time
    for i in range(n):
        for j in range(0, n-i-1):
            if arrival_times[j] > arrival_times[j+1]:
                arrival_times[j], arrival_times[j+1] = arrival_times[j+1], arrival_times[j]
                burst_times[j], burst_times[j+1] = burst_times[j+1], burst_times[j]
                processes[j], processes[j+1] = processes[j+1], processes[j]

    # Calculate completion time for each process
    completion_time = [0] * n
    completion_time[0] = max(arrival_times[0], 0) + burst_times[0]
    for i in range(1, n):
        completion_time[i] = max(completion_time[i-1], arrival_times[i]) + burst_times[i]

    # Calculate waiting time for each process
    waiting_time = [0] * n
    for i in range(n):
        waiting_time[i] = max(0, completion_time[i] - arrival_times[i] - burst_times[i])

    # Calculate turnaround time for each process
    turnaround_time = [0] * n
    for i in range(n):
        turnaround_time[i] = completion_time[i] - arrival_times[i]

    # Calculate average turnaround time and waiting time
    avg_turnaround_time = sum(turnaround_time) / n
    avg_waiting_time = sum(waiting_time) / n

    # Display the results
    print("Process\tBurst Time\tArrival Time\tCompletion Time\tWaiting Time\tTurnaround Time")
    for i in range(n):
        print(f"{processes[i]}\t\t{burst_times[i]}\t\t{arrival_times[i]}\t\t{completion_time[i]}\t\t{waiting_time[i]}\t\t{turnaround_time[i]}")

    print(f"\nAverage Turnaround Time: {avg_turnaround_time}")
    print(f"Average Waiting Time: {avg_waiting_time}")

# User input
n = int(input("Enter the number of processes: "))
processes = []
burst_times = []
arrival_times = []

for i in range(n):
    processes.append(i+1)
    arrival_times.append(int(input(f"Enter arrival time for Process {i+1}: ")))
    burst_times.append(int(input(f"Enter burst time for Process {i+1}: ")))

fcfs(processes, burst_times, arrival_times)
