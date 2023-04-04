#!/bin/bash

usage () {
    echo "Usage: ${0} : [OPTION]... COMMAND..."
    echo
    echo "blabla"
    echo "    -n: dry run"
    echo "    -s: run the command with sudo"
    echo "    -v: verbose mode"
    echo "    -f: FILE"
    echo "    -h: help"
}

FILE='./servers'
DRY='false'
SUDO='false'

while getopts nsvhf: OPTION
do

    case ${OPTION} in
        n);;
        s);;
        v);;
        h)
            usage
            exit 0
            ;;
        f) FILE=${OPTARG}
            ;;
        ?)
            usage >&2
            exit 1
            ;;
    esac
done

shift "$(( ${OPTIND} - 1 ))"

if [[ ${#} -eq 0 ]]
then
    echo "There is no command to execute" >&2
    usage >&2
    exit 1
fi

if [[ -e ${FILE} ]]
then
    
    cat ${FILE} | while read LINE
    do
        # Connection
        ssh -o ConnectTimeout=2 $(id -un)|${LINE}
        echo ${LINE}
    done
else
    echo "The file ${FILE} doesn't exist" >&2
    exit 1
fi


echo "commandes : ${@}"

for ARG in ${@}
do
    echo "$ARG"
done
