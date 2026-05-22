#!/bin/bash

convert_to_18() {
    local id=$1
    local suffix=""
    local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ012345"

    for i in {0..2}; do
        local chunk=${id:$((i*5)):5}
        local value=0
        for j in {0..4}; do
            if [[ ${chunk:$j:1} =~ [A-Z] ]]; then
                value=$((value + 2**$j))
            fi
        done
        suffix="${suffix}${chars:$value:1}"
    done

    echo "${id}${suffix}"
}

if [ $# -eq 0 ]; then
    echo "Please provide a 15-digit Salesforce ID as an argument."
    exit 1
fi

input_id=$1

if [[ ! $input_id =~ ^[a-zA-Z0-9]{15}$ ]]; then
    echo "Invalid input. Please provide a valid 15-digit Salesforce ID."
    exit 1
fi

result=$(convert_to_18 "$input_id")
echo "18-digit Salesforce ID: $result"