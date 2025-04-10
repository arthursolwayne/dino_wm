#!/bin/bash

LOG_FILE="run_log.txt"
echo "🌟 Starting multi-GPU experiment runs at $(date)" | tee -a $LOG_FILE
echo "==============================================" | tee -a $LOG_FILE

run_task() {
    NAME=$1
    CONFIG=$2

    echo "🚀 Starting $NAME..." | tee -a $LOG_FILE
    START_TIME=$(date)
    echo "[START] $NAME at $START_TIME" | tee -a $LOG_FILE

    accelerate launch --multi_gpu plan.py --config-name "$CONFIG" model_name="$NAME" 2>&1 | tee -a $LOG_FILE

    END_TIME=$(date)
    echo "[END] $NAME at $END_TIME" | tee -a $LOG_FILE
    echo "✅ Finished $NAME!" | tee -a $LOG_FILE
    echo "----------------------------------------------" | tee -a $LOG_FILE
}

run_task "point_maze" "plan_point_maze.yaml"
run_task "pusht" "plan_pusht.yaml"
run_task "wall" "plan_wall.yaml"

echo "🎉 All tasks complete at $(date)" | tee -a $LOG_FILE
