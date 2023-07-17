#!/bin/bash

# 设置输出文件
output_file="output0701.txt"

# 清空输出文件
> $output_file

# 定义函数，执行命令并将结果追加到输出文件
execute_command() {
    local command=$1
    local label=$2

    # 执行命令并计时
    start_time=$(date +%s.%N)
    $command >> $output_file
    end_time=$(date +%s.%N)

    # 计算执行时间
    execution_time=$(echo "$end_time - $start_time" | bc)

    # 输出执行时间
    echo "$label Execution Time: $execution_time seconds" >> $output_file
    echo >> $output_file
}

# 执行多条命令按序执行

execute_command "mpirun -np 8 ./graph500_reference_bfs 15 16" "Command 1"
execute_command "mpirun -np 4 ./graph500_reference_bfs 15 16" "Command 2"
execute_command "mpirun -np 2 ./graph500_reference_bfs 15 50" "Command 3"
execute_command "mpirun -np 1 ./graph500_reference_bfs 15 50" "Command 4"
execute_command "mpirun -np 8 ./graph500_reference_bfs 10 50" "Command 5"
execute_command "mpirun -np 4 ./graph500_reference_bfs 10 50" "Command 6"
execute_command "mpirun -np 2 ./graph500_reference_bfs 10 50" "Command 7"
execute_command "mpirun -np 1 ./graph500_reference_bfs 10 50" "Command 8"
execute_command "mpirun -np 8 ./graph500_reference_bfs_sssp 15 50" "Command 1"
execute_command "mpirun -np 4 ./graph500_reference_bfs_sssp 15 50" "Command 2"
execute_command "mpirun -np 2 ./graph500_reference_bfs_sssp 15 50" "Command 3"
execute_command "mpirun -np 1 ./graph500_reference_bfs_sssp 15 50" "Command 4"
execute_command "mpirun -np 8 ./graph500_reference_bfs_sssp 10 50" "Command 5"
execute_command "mpirun -np 4 ./graph500_reference_bfs_sssp 10 50" "Command 6"
execute_command "mpirun -np 2 ./graph500_reference_bfs_sssp 10 50" "Command 7"
execute_command "mpirun -np 1 ./graph500_reference_bfs_sssp 10 50" "Command 8"



