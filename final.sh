#!/bin/bash

# variables from args.txt
args=()
input_file=""
output_file=""
original_string=""
replacement_string=""

# how many replacements are made
count=0

increment_count() {
    local -n ref_count=count  # Create a nameref pointing to the global variable 'count'
    ((ref_count++))           # Increment the value of the global variable through the nameref
}

# extract the values from args.txt and assign them to the args array
function extract_args {
    # read throuh the args.txt file
    LINE=1
    while read -r CURRENT_LINE || [[ -n "$CURRENT_LINE" ]]; do

        # split the line string by "=" and store the split parts in an array
        IFS="=" read -r -a array <<< "$CURRENT_LINE"

        # append the value into the args array
        # args[$LINE-1] = array[1] <- pseudo-code for readability's sake
        args["$(($LINE-1))"]="${array[1]}"

        # increment the line being read
        ((LINE++))

    done < "args.txt"
}

# assign variables from args[] values
function assign_args {
    input_file="${args[0]}"
    output_file="${args[1]}"
    original_string="${args[2]}"
    replacement_string="${args[3]}"
}

# $1 full string
# $2 substring to replace
# $3 replacement to string
function replace_substring {
    local original_string="$1"
    local substring_to_replace="$2"
    local replacement_string="$3"

    # perform the replacement using parameter expansion
    local new_string="${original_string//$substring_to_replace/$replacement_string}"

    # update counter
    if [[ "$original_string" != "$new_string" ]]; then
        increment_count
    fi

    # return
    echo "$new_string"
}

function create_new_copy {
    # check if the input file exists
    if [[ -f "$input_file" ]]; then
        # empty or create the output file
        > "$output_file"

        # read through input_file, and write to output_file
        LINE=1
        while read -r CURRENT_LINE || [[ -n "$CURRENT_LINE" ]]; do
            # perform the substring replacement
            modified_line=$(replace_substring $CURRENT_LINE $original_string $replacement_string)

            # write the modified line to the output file
            echo "$modified_line" >> "$output_file"
            ((LINE++))
        done < "$input_file"

        echo "File processed. New file saved to $output_file"
        
        # echo ""$count" replacements made"

    # input file doesn't exist
    else
        echo "Input file does not exist: $input_file"
        echo "Double-check your file path"
    fi
}


# function calls
extract_args
assign_args
create_new_copy