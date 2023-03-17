#!/bin/bash

# # --------------------------------------------------
# !prout   # Last command which begins by prout
# !!       # Last command
# !$       # Last argument of the last command

# # --------------------------------------------------
cut -d ':' -f 1 /etc/passwd
awk '{print $NF}' /etc/passwd
awk -F ':' '{print $1}' /etc/passwd
awk -F ':' '{print $3}' /etc/passwd | sort -n
awk -F ':' '{print $NF}' /etc/passwd | sort | uniq -c
awk -F 'blah, aaa' '{print $(NF - 3)}'

# # --------------------------------------------------
grep -i 'Failed' "${1}" | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
    if [[ "${COUNT}" -gt 10 ]]
    ...


# # -MATHS--------------------------------------------
NUM=$(( 1 + 2 ))
(( NUM++ ))
NUM=$(( VAL1 + VAL2 )) # $ useless

NUM=$(echo '6 / 4.654' | bc -l)
# bc -l to open a calculator

NUM=$(awk 'BEGIN {print 6/4}') # Cumbersome

let NUM='2+3'
let NUM++

NUM=$(expr 2 + 3)

# # -REDIRECTIONS-------------------------------------
FILE="/tmp/data"
ERR_FILE="/tmp/data.err"

# Redirect STDOUT to a file.
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDERR to STDOUT
head -n3 /etc/passwd /fakefile 2>&1 # Without &, bash creates a file name '1'

# Redirect STDERR to a file
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to a file.
head -n3 /etc/passwd /fakefile &> ${FILE}

# Redirect STDOUT and STDERR through a pipe.
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
echo "This is STDERR!" >&2

# Discard STDOUT
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STDERR
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
head -n3 /etc/passwd /fakefile &> /dev/null

# # -PARAMETERS---------------------------------------
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
if [[ "${1}" = start ]]
then
    echo 'Starting.'
else
    echo 'Please enter start' >&2
    exit 1
fi

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

# # --------------------------------------------------
special_char ()
{
    readonly SPECIAL="|&~!#@?$^-_*/"
    [[ -v 1 ]] && NUM=${1} || NUM=1

    for ((i = 0; i < ${NUM}; i++)); do
        echo -n "$(echo ${SPECIAL} | fold -w1 | shuf | head -c1)"
    done

    return 0
}

PASSWORD="$(echo "$(date +%s)$(special_char 5)" | sha256sum | head -c10)$(special_char)"

echo "${PASSWORD}"
special_char 10

# # --------------------------------------------------
locate prout
find / -name 'prout'
