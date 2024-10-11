#!/bin/bash

echo "
Running deployment script..."

# the file that hosts the argument variables
args_file="dir_args.txt"

# variables from the args file
args=()
input_dir=""
output_dir=""
original_string=""
replacement_string=""

# extract the values from the args file and assign them to the args array
function extract_args {
    # read through the args file
    LINE=1
    while read -r CURRENT_LINE || [[ -n "$CURRENT_LINE" ]]; do

        # split the line string by "=" and store the split parts in an array
        IFS="=" read -r -a array <<< "$CURRENT_LINE"

        # append the value into the args array
        # args[$LINE-1] = array[1] <- pseudo-code for readability's sake
        args["$(($LINE-1))"]="${array[1]}"

        # increment the line being read
        ((LINE++))

    done < "$args_file"
}

# assign variables from args[] values
function assign_args {
    input_dir="${args[0]}"
    output_dir="${args[1]}"
    original_string="${args[2]}"
    replacement_string="${args[3]}"
}

#
# $1 filename from input_dir
function create_output_file_name {
    # input_dir/*/filename -> output_dir/*/filename
    # output_dir + / + $1.split(/)[1, ...]
    # split the input's filename by the first "/"
    IFS="/" read -r 1st_part 2nd_part <<< "$1"
}

# function calls
extract_args
assign_args

echo "
_______ARGUMENTS_______
input_dir: "$input_dir"
output_dir: "$output_dir"
original_string: "$original_string"
replacement_string: "$replacement_string"
"

echo "
___Directories before replacement___
input_dir:"
ls input_dir
echo "
output_dir:"
ls output_dir



echo "
___Directories after replacement___
input_dir:"
ls input_dir
echo "
output_dir:"
ls output_dir