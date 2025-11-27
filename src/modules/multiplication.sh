#!/bin/bash

# Multiplication module
# Performs multiplication of two numbers

multiplication() {
    local first=$1
    local second=$2

    # Use bc for floating point arithmetic
    echo "${first} * ${second}" | bc
}
