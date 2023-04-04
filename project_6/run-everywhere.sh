#!/bin/bash

FILE='./servers'
DRY='false'
SUDO=''
VERBOSE='false'
WORSE_EXIT_STATUS='0'


usage () {
    echo "Usage: ${0} : [-nsvh] [-f FILE] COMMAND"
    echo
    echo 'Executes COMMAND as a single command on every server.'
    echo '    -n     dry run mode. Display the COMMAND that would have been executed and exit.'
    echo '    -s     run the COMMAND with sudo.'
    echo '    -v     verbose mode.'
    echo "    -f     FILE. Default '${FILE}'."
    echo '    -h     help.'
}

dryrun ()
{
    if [[ ${DRY} = 'true' ]]
    then
        echo "DRY RUN: ${@}"
    else
        ${@}
    fi
}

# Force using -s agrument for sudo
# if [[ ${UID} -eq 0 ]]
# then
#     echo "Please use the argument -s instead of running this command as root" >&2
#     usage >&2
#     exit 1
# fi

# --
while getopts nsvhf: OPTION
do

    case ${OPTION} in
        n) DRY='true' ;;
        s) SUDO='sudo -S' ;;
        v) VERBOSE='true' ;;
        h)
            usage
            exit 0
            ;;
        f) FILE=${OPTARG} ;;
        ?)
            usage >&2
            exit 1
            ;;
    esac
done

# Commands ? --
shift "$(( ${OPTIND} - 1 ))"

if [[ ${#} -eq 0 ]]
then
    echo "There is no command to execute" >&2
    usage >&2
    exit 1
fi

# File with server addresses ? --
if [[ ! -e "${FILE}" ]]
then
    echo "The file '${FILE}' doesn't exist" >&2
    usage >&2
    exit 1
fi

for SERVER in $(cat "${FILE}")
do
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo
        echo "-- Connection to ${SERVER}"
    fi

    dryrun ssh -o ConnectTimeout=2 ${SERVER} ${SUDO} ${@} 2> /dev/null
    LAST_EXIST_STATUS="${?}"

    if [[ "${LAST_EXIST_STATUS}" -ne 0 ]]
    then
        echo "Execution on ${SERVER} failed."
        WORSE_EXIT_STATUS="${LAST_EXIST_STATUS}"
    fi
done

exit "${WORSE_EXIT_STATUS}"
