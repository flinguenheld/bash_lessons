#!/bin/bash

FILE="tmp.txt"
CSV="attackers.csv"

if [[ ! -e "${1}" ]]
then
    echo "The file '${1}' doesn't exist" >&2
    echo "Usage: $(basename ${0}) FILENAME" >&2
    exit 1
fi

# grep -i 'Failed' "${1}" | awk '{print $11}' | sort -n | uniq -c | sort -n
# grep -i 'Failed' "${1}" | awk '/from/'

grep -i 'Failed' "${1}" | awk '{if ($9 == "invalid") print $13; else print $11}' | sort -n | uniq -c | sort -n | awk '($1>=10)' > ${FILE}

echo "Count,IP,Location" > ${CSV}

while read line
do
    NB=$(echo $line | awk '{print $1}')
    IP=$(echo $line | awk '{print $2}')
    GEO=$(geoiplookup $(echo $line | awk '{print $2}') | awk '{print $5}')

    echo "${NB},${IP},${GEO}" >> ${CSV}
    echo "${NB} ${IP} ${GEO}"
done <${FILE}

rm ${FILE}
