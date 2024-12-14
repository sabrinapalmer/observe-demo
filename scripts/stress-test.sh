#!/bin/bash
# stress-test.sh

# Function to perform CPU-intensive calculation
stress_cpu() {
    end=$((SECONDS+300))  # Run for 5 minutes
    while [ $SECONDS -lt $end ]; do
        for i in {1..1000000}; do
            echo "scale=10; 4*a(1)" | bc -l >/dev/null
        done
    done
}

echo "Starting CPU stress test..."
stress_cpu
echo "CPU stress test completed"