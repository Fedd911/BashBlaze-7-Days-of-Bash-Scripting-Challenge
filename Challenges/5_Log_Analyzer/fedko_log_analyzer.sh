#!/bin/bash

path_to_log=$1

timestamp=$(date '+%y-%m-%d_%H:%M:%S')

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" & > /dev/null && pwd)

error_count=$(grep -o 'ERROR\|FAILED' "$path_to_log" | wc -l)

occurunces=$(awk '{print $3}' "$path_to_log" | sort | uniq -c | sort -gr | head -n 5 | while read line; do echo "Occurunces: $line" ; done )


summary="log_summary_"$timestamp".txt"

function generateReport {

        echo "------------------------------------------------"
        echo "Date of analysis: $timestamp"
        echo
        echo "Log file name: $(basename "$path_to_log")"
        echo
        echo "Total lines processed: $(wc -l "$path_to_log" | awk '{print $1}')"
        echo "------------------------------------------------"
        echo
        echo "---------------- ERROR COUNT -------------------"
        echo
        echo "Total ERROR count: $error_count."
        echo
        echo "------------------ OCCURUNCES ------------------"
        echo
        echo "$occurunces"
        echo
        echo "--------------- CRITICAL EVENTS ----------------"
        echo
        grep -n 'CRITICAL' "$path_to_log"
        echo
        echo "------------------------------------------------"
}

generateReport > "$summary"

echo "Summary report generated: $summary"
