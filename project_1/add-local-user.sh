#!/bin/bash

# This script creates a new user on the local system

# Only for root user
if [[ "${UID}" -eq 0 ]]
then
    echo "Hello root"
    echo "This script allows to create a new user"
else
    echo "This scrip is only for root users"
    return 1
fi

# Username ? 
read -p 'Enter the username: ' USERNAME

# Full name ?
read -p 'Enter the full name: ' COMMENT

# Initial password ?
read -p 'Enter the password: ' PASSWORD

# Create newuser
useradd -c "${COMMENT}" --create-home ${USERNAME}

if [[ "${?}" -ne 0 ]]
then
    echo "The user creation failed with the code ${?}"
    exit 1
fi

# Set password
echo ${USERNAME}:${PASSWORD} | chpasswd

if [[ "${?}" -ne 0 ]]
then
    echo "The password could not be set"
    exit 1
fi

# Force password change on first login
passwd -e ${USERNAME}

# Display information
echo "--------------------"
echo "New user created : "
echo "In the hostname: ${HOSTNAME}"
echo "username: ${USERNAME}"
echo "comment: ${COMMENT}"
echo "temporary pass: ${PASSWORD}"
echo "--------------------"
