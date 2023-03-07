#!/bin/bash

# Only for root
if [[ "${UID}" -ne 0 ]]
then
    echo "Please use this script with root privileges." >&2
    exit 1
fi

# Usage
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: add_new_local_user USERNAME [COMMENTS]..." >&2
    exit 1
fi

# Take the username then regroup all other parameters in comment
USERNAME="${1}"

shift
COMMENT="${@}"

# Add user
useradd -c "${COMMENT}" --create-home "${USERNAME}" &> /dev/null

if [[ "${?}" -ne 0 ]]
then
    echo "The user '${USERNAME}' cannot be created" >&2
    exit 1
fi

# Generate and set the password
PASSWORD="$(date +%s%N | sha256sum | head -c10)"
echo "${USERNAME}:${PASSWORD}" | chpasswd &> /dev/null

# Check to see if the password has been set
if [[ "${?}" -ne 0 ]]
then
    echo "The password cannot be set" >&2
    exit 1
fi

# Force user to create a new password
passwd -e "${USERNAME}" &> /dev/null

# Display information
echo "-- Creation ok --"
echo "username: ${USERNAME}"
echo "comment: ${COMMENT}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"
echo "-----------------"
exit 0
