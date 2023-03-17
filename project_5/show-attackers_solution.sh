#!/bin/bash

MAX=10
CSV="attackers.csv"

if [[ ! -e "${1}" ]]
then
    echo "The file '${1}' doesn't exist" >&2
    echo "Usage: $(basename ${0}) FILENAME" >&2
    exit 1
fi

echo "Count,IP,Location" > ${CSV}

# grep -i 'Failed' "${1}" | awk -F 'from ' '{print $2}' | awk '{print $1}' | sort | uniq -c
grep -i 'Failed' "${1}" | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
    if [[ "${COUNT}" -gt "${MAX}" ]]
    then
        GEO=$(geoiplookup "${IP}" | awk -F ', ' '{print $2}')

        echo "${COUNT} ${IP} ${GEO}"
        echo "${COUNT},${IP},${GEO}" >> ${CSV}
    fi
done
