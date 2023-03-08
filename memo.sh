#!/bin/bash

# # --------------------------------------------------
# FILE="/tmp/data"
# ERR_FILE="/tmp/data.err"

# # Redirect STDOUT to a file.
# head -n1 /etc/passwd > ${FILE}

# # Redirect STDIN to a program.
# read LINE < ${FILE}
# echo "LINE contains: ${LINE}"

# # Redirect STDERR to STDOUT
# head -n3 /etc/passwd /fakefile 2>&1 # Without &, bash creates a file name '1'

# # Redirect STDERR to a file
# head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# # Redirect STDOUT and STDERR to a file.
# head -n3 /etc/passwd /fakefile &> ${FILE}

# # Redirect STDOUT and STDERR through a pipe.
# head -n3 /etc/passwd /fakefile |& cat -n

# # Send output to STDERR
# echo "This is STDERR!" >&2

# # Discard STDOUT
# head -n3 /etc/passwd /fakefile > /dev/null

# # Discard STDERR
# head -n3 /etc/passwd /fakefile 2> /dev/null

# # Discard STDOUT and STDERR
# head -n3 /etc/passwd /fakefile &> /dev/null


# # --------------------------------------------------
# Parameters: "${1}" "${2}" ...
# Number of parameters: "${#}"
# All parameters in one variable: "${@}"

for P in "${@}"
do
    echo "${P}"
done

while [[ "${#}" -ne 0 ]]; do
    echo "First parameter: ${1}"
    shift
done


# # --------------------------------------------------
# if [[ "${1}" = start ]]
# then
#     echo 'Starting.'
# else
#     echo 'Please enter start' >&2
#     exit 1
# fi

case "${1}" in
    start)
        echo 'Starting.'
        ;;
    stop)
        echo 'Stop.'
        ;;
    conti*|again)
        echo 'Continue.'
        ;;
    *)
        echo 'Please enter a valid option' >&2
        exit 100
        ;;
esac
