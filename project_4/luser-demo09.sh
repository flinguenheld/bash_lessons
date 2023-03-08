#!/bin/bash

# Test case !

if [[ "${1}" = start ]]
then
    echo "Starting."
fi


case "${1}" in
    start)
        echo 'Starting.'
        ;;
esac
