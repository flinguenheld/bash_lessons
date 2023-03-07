#!/bin/bash

# Only for root
if [[ "${UID}" -ne 0 ]]
then
    echo "Please use this script with root privileges."
    exit 1
fi

# Usage
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: add_new_local_user USERNAME [COMMENTS]..."
    exit 1
fi

# Take the username then regroup all other parameters in comment
USERNAME="${1}"
# COMMENT=""
# while [[ "${#}" -ne 0 ]]; do
#     shift
#     COMMENT="${COMMENT} ${1}"
# done

# COMMENT="${COMMENT:1}"
# This loop can be replaced by @ -_-`
shift
COMMENT="${@}"

# Add user
useradd -c "${COMMENT}" --create-home "${USERNAME}"

if [[ "${?}" -ne 0 ]]
then
    echo "The user '${USERNAME}' cannot be created"
    exit 1
fi

# Generate and set the password
# SPECIAL="$(echo '&|~!?*-_><' | fold -w1 | shuf | head -n1)"
# PASSWORD="$(echo ${RANDOM}${SPECIAL}${USERNAME} | sha256sum | head -c10)"
PASSWORD="$(date +%s%N | sha256sum | head -c10)"
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Check to see if the password has been set
if [[ "${?}" -ne 0 ]]
then
    echo "The password cannot be set"
    exit 1
fi

# Force user to create a new password
passwd -e "${USERNAME}"

# Display information
echo "New user:"
echo
echo "username: ${USERNAME}"
echo "comment: ${COMMENT}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"
