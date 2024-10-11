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

function remove_invisible_chars() {
    local input="$1"
    # Use 'tr' to remove non-printable characters and control characters
    # but keep spaces
    echo "$input" | tr -cd '[:print:][:space:]'
}

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

# remove invisible characters from the args
function clean_args {
    input_dir="$(remove_invisible_chars "$input_dir")"
    output_dir="$(remove_invisible_chars "$output_dir")"
    original_string="$(remove_invisible_chars "$original_string")"
    replacement_string="$(remove_invisible_chars "$replacement_string")"
}

#
# $1 filename from input_dir
function create_output_file_name {
    # split the input's filename by the first "/"
    IFS="/" read -r first_part second_part <<< "$1"
    
    local output_file_name=""$output_dir"/"$second_part""

    # echo "running create_output_file_name..."
    # echo -E "input_file_name: $1"
    # echo -E "first_input: $first_part"
    # echo -E "second_part: $second_part"
    # echo -E "output_dir: $output_dir"
    # declare -p output_dir
    echo -E "output_file_name: "$output_file_name""
}

# function calls
extract_args
assign_args
clean_args

echo "
_______ARGUMENTS_______
input_dir: "$input_dir"
output_dir: "$output_dir"
original_string: "$original_string"
replacement_string: "$replacement_string"
"

# echo "
# ___Directories before replacement___
# input_dir:"
# ls input_dir
# echo "
# output_dir:"
# ls output_dir

# output directory should mirror the input directory
# files can be empty

create_output_file_name input_dir/input.txt

# echo "
# ___Directories after replacement___
# input_dir:"
# ls input_dir
# echo "
# output_dir:"
# ls output_dir