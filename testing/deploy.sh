#!/bin/bash

# define functions

arg1=""
arg2=""
args=()

# extract & parse the filenames to assign them to the args variables
function extractFilesFromArgs {
    echo "Extracting filenames..."
    echo "$1: $2"
    echo "Index: $(($1-1))"

    IFS="=" read -r -a array <<< "$2"
    echo "Extracted filename: ${array[1]}"
    args["$(($1-1))"]="${array[1]}"
}

# read and parse args.txt
function option1 {
    LINE=1
    while read -r CURRENT_LINE || [[ -n "$CURRENT_LINE" ]]
        do
            # echo "$LINE: $CURRENT_LINE"
            extractFilesFromArgs $LINE $CURRENT_LINE
        ((LINE++))
    done < "args.txt"
}

# print to console the args variables
function option2 {
    echo "args: "
    for arg in "${args[@]}"; do
        echo "$arg"
    done
}

# copy content from args[0] to args[1]
function option3 {
    echo "copying contents over"

    arg1="${args[0]}"
    arg2="${args[1]}"
    cp "$arg1" "$arg2"
    echo "content copied from "$arg1" to "$arg2". "$arg2" content: "
    cat "$arg2"
}

# replace a substring within a string
# $1 full string
# $2 substring to replace
# $3 replacement string
function replaceSubstring {
    local original_string="$1"
    local substring_to_replace="$2"
    local replacement_string="$3"

    # echo "Original: "$original_string""

    # perform the replacement using parameter expansion
    local new_string="${original_string//$substring_to_replace/$replacement_string}"
    # echo "New: "$new_string""
    echo "$new_string"
}

# find and replace all instances of a string within a file
# $1 filepath
# $2 string to find
# $3 replacement string
function option4 {
    echo "option4 called. Find and replace B)"
    foundLines=()
    echo "filepath: "$1"
string to find: "$2"
replacement string: "$3"
"
    input_file="$1"
    output_file="replaced_output.txt"

    # Empty or create the output file
    > "$output_file"

    LINE=1
    while read -r CURRENT_LINE || [[ -n "$CURRENT_LINE" ]]; do
         echo "reading line: "$LINE""

        # perform the substring replacement
         modified_line=$(replaceSubstring $CURRENT_LINE $2 $3)

        # write the modified line to the output file
        echo "$modified_line" >> "$output_file"
        
        ((LINE++))
    done < "$1"
}

# run the CLI
echo "
Deployment assistant is running."

input=""
killCode="abort"

while [[ "$input" != "abort" ]]; do 
    read -p "
User input: " input

    if [[ "$input" == "1" ]] then option1 
    elif [[ "$input" == "2" ]] then option2
    elif [[ "$input" == "3" ]] then option3
    elif [[ "$input" == "4" ]] then option4 ${args[1]} red RED
    else echo "Choose a valid option >:("
    fi

done

# exit message
echo "
Script done"