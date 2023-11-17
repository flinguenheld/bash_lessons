# ------------------------------------------------------------------------------------- One fer ---
echo "One for ${1-you}, one for me."  # null
echo "One for ${1:-you}, one for me." # : unset or null

(($# == 0)) && NAME=you || NAME="$1" # Ternary
echo "One for ${NAME}, one for me."

# ----------------------------------------------------------------------------------- Raindrops ---
(($1 % 3)) || TXT+="Pling"
(($1 % 5)) || TXT+="Plang"
(($1 % 7)) || TXT+="Plong"

echo ${TXT:-$1}

# ---------------------------------------------------------------------------- Hamming distance ---
usage() {
	echo "Usage: hamming.sh <string1> <string2>"
}

(($# != 2)) && usage && exit 1
((${#1} != ${#2})) && usage && echo "strands must be of equal length" && exit 1

DISTANCE='0'
for ((i = 0; i < ${#1}; i++)); do
	[ "${1:$i:1}" != "${2:$i:1}" ] && ((DISTANCE++))
done

echo $DISTANCE

# ------------------------------------------------------------------------------------- Acronym ---
STR="${1^^}"
STR="${STR//-/ }"
STR="${STR//[^A-Z\ ]/}"

printf "%c" $STR

# --------------------------------------------------------------------------- Armstrong Numbers ---
for NB in $(echo "$1" | fold -w1); do
	TOTAL=$((TOTAL + NB ** ${#1}))
done

((TOTAL == "$1")) && echo "true" || echo "false"

# ------------------------------------------------------------------------------------- Pangram ---
[[ -z $(echo "abcdefghijklmnopqrstuvwxyz" | sed "s/[${1,,} ]//g") ]] && echo "true" || echo "false"

# TXT=$(echo "${1,,}" | sed -E 's/[^a-z]//g' | fold -w1 | sort | uniq | tr -d "\n")
# [[ "$TXT" = "abcdefghijklmnopqrstuvwxyz" ]] && echo "true" || echo "false"

# ------------------------------------------------------------------------------ Scrabble score ---
STR="${1^^}"
STR="${STR//[^A-Z]/}"
echo ${STR} | sed -e 's/[AEIOULNRST]/1+/g; s/[DG]/2+/g; s/[BCMP]/3+/g; s/[FHVWY]/4+/g; s/[K]/5+/g;s/[JX]/8+/g; s/[QZ]/10+/g; s/$/0/' | bc

# -------------------------------------------------------------------------------------- Grains ---
case "$1" in
total)
	printf '%u' -1
	;;
[1-9] | [1-5][0-9] | 6[0-4])
	printf '%u' $((1 << ($1 - 1)))
	;;
*)
	echo 'Error: invalid input' 1>&2
	exit 1
	;;
esac

# ---------------------------------------------------------------------------------------- Luhn ---
# TOTAL=$(echo $STR | rev | tr ' ' '\n' | while read LINE; do
#
# 	echo $LINE | fold -w1 | sed '1~2n;s/$/*2/'
#
# done | bc | sed 's/[0-9][0-9]$/&-9/' | paste -sd+ | bc)
STR="${1//[[:space:]]/}"

if echo "$STR" | grep -q "[^0-9]" || [[ ${#STR} -lt 2 ]]; then
	echo "false"
	exit
fi

# Farfetched but it works
[[ $(echo "$STR" | rev | fold -w1 | sed '1~2n;s/$/*2/' | bc | sed 's/[0-9][0-9]$/&-9/' | paste -sd+ | bc | sed 's/$/\%10/' | bc) == 0 ]] && echo "true" || echo "false"

# ------------------------------------------------------------------------------- Atbash Cipher ---
STR=$(echo "${STR//[^a-z0-9]/}" | tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba")

# ------------------------------------------------------------------------------ Resistor Color ---
STR="${1^^}${2^^}"
STR=$(echo "$STR" | sed 's/BLACK/0/g;s/BROWN/1/g;s/RED/2/g;s/ORANGE/3/g;s/YELLOW/4/g;s/GREEN/5/g;s/BLUE/6/g;s/VIOLET/7/g;s/GREY/8/g;s/WHITE/9/g')

if [[ ${#STR} != 2 ]] || echo "$STR" | grep -q "[^0-9]"; then
	echo "invalid color" >&2
	exit 1
else
	echo "${STR/#0/}"
fi

# ------------------------------------------------------------------------------ Resistor Color ---
