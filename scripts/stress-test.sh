echo "[$(date)] Starting CPU stress test..."

# Run the entire stress test within a single command
timeout 360 bash -c '
    start_time=$(date +%s)
    end_time=$((start_time + 300))  # 5 minutes
    interval=0
    
    echo "[$(date)] CPU stress test will run for 5 minutes"
    
    while [ $(date +%s) -lt $end_time ]; do
        # Print progress every 10 seconds
        current_time=$(date +%s)
        if [ $((current_time - start_time)) -ne $interval ]; then
            interval=$((current_time - start_time))
            if [ $((interval % 10)) -eq 0 ]; then
                remaining=$((end_time - current_time))
                echo "[$(date)] Progress: $interval seconds elapsed, $remaining seconds remaining"
            fi
        fi
        
        # Less intensive calculation, but still creates CPU load
        for i in {1..10000}; do
            echo "scale=5; 4*a(1)" | bc -l >/dev/null
        done
        
        # Small sleep to prevent complete CPU saturation
        sleep 0.1
    done
'

# Check if the script completed normally
if [ $? -eq 0 ]; then
    echo "[$(date)] CPU stress test completed successfully"
else
    echo "[$(date)] CPU stress test was terminated"
    exit 1
fi