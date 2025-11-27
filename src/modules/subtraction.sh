#!/bin/bash

# Subtraction module
# Performs subtraction of two numbers

subtraction() {
    local first=$1
    local second=$2

    # Use bc for floating point arithmetic
    echo "${first} - ${second}" | bc
}
