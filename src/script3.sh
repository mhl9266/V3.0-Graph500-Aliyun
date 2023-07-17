#!/bin/bash

# 设置输出文件
output_file="output3.txt"

# 清空输出文件
> $output_file

# 定义函数，执行命令并将结果追加到输出文件
execute_command() {
    local command=$1
    local label=$2

    # 执行命令并计时
    start_time=$(date +%s.%N)
    valgrind --tool=massif --massif-out-file=massif.out $command >/dev/null 2>&1
    end_time=$(date +%s.%N)

    # 计算执行时间
    execution_time=$(echo "$end_time - $start_time" | bc)

    # 输出执行时间
    echo "$label Execution Time: $execution_time seconds" >> $output_file
    echo >> $output_file

    # 提取内存占用信息
    mem_usage=$(ms_print massif.out | grep "mem_heap_B" | awk '{print $2}')
    
    # 输出内存占用信息
    echo "$label Memory Usage: $mem_usage bytes" >> $output_file
    echo >> $output_file
}

# 执行命令，并计时和获取内存占用
command="mpirun -np 8 ./graph500_reference_bfs 25 100"
label="Command: np=8, scale=100"
execute_command "$command" "$label"

