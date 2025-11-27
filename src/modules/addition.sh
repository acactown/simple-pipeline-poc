#!/bin/bash

# Addition module
# Performs addition of two numbers

addition() {
    local first=$1
    local second=$2

    # Use bc for floating point arithmetic
    echo "${first} + ${second}" | bc
}
