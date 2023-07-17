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

# 定义参数列表
processes=(2 4)
scales=(20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35)
params=(16)

# 执行多条命令按序执行，并计时
for process in "${processes[@]}"
do
    for scale in "${scales[@]}"
    do
        for param in "${params[@]}"
        do
            command="mpirun -np $process ./graph500_reference_bfs_sssp $scale $param"
            label="Command: np=$process, scale=$scale, param=$param"
            execute_command "$command" "$label"
        done
    done
done

