def round_robin(processes, time_quantum):
    n = len(processes)
    remaining_time = [process[2] for process in processes]
    waiting_time = [0] * n
    turnaround_time = [0] * n
    completion_time = [0] * n

    time = 0
    queue = []

    while True:
        all_finished = True

        for i in range(n):
            if remaining_time[i] > 0:
                all_finished = False

                if remaining_time[i] > time_quantum:
                    time += time_quantum
                    remaining_time[i] -= time_quantum
                    queue.append((processes[i][0], time - time_quantum, time))
                else:
                    time += remaining_time[i]
                    waiting_time[i] = time - processes[i][1] - processes[i][2]
                    remaining_time[i] = 0
                    queue.append((processes[i][0], time - processes[i][2], time))
                    turnaround_time[i] = time - processes[i][1]

        if all_finished:
            break

    print("\nExecution Sequence:")
    for process in queue:
        print("Process {}: {} to {}".format(process[0], process[1], process[2]))

    average_turnaround_time = sum(turnaround_time) / n
    average_waiting_time = sum(waiting_time) / n

    print("\nAverage Turnaround Time:", average_turnaround_time)
    print("Average Waiting Time:", average_waiting_time)


if __name__ == "__main__":
    num_processes = int(input("Enter the number of processes: "))
    
    processes = []
    for i in range(num_processes):
        process_name = input("Enter Process Name for Process {}: ".format(i + 1))
        arrival_time = int(input("Enter Arrival Time for {}: ".format(process_name)))
        burst_time = int(input("Enter Burst Time for {}: ".format(process_name)))
        processes.append((process_name, arrival_time, burst_time))

    time_quantum = int(input("Enter the time quantum: "))

    round_robin(processes, time_quantum)
