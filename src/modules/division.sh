#!/bin/bash

# Division module
# Performs division of two numbers

division() {
    local first=$1
    local second=$2

    # Check for division by zero
    if (( $(echo "${second} == 0" | bc -l) )); then
        echo "Error: Division by zero" >&2
        return 1
    fi

    # Use bc for floating point arithmetic with scale of 2 decimal places
    echo "scale=2; ${first} / ${second}" | bc
}
