#! /bin/sh

set -o errexit
set -o nounset

print_instructions_and_exit () {
	echo "Usage: $0 quick|full user@example.org .." >&2
	exit 1
}


TYPE="${1:-}"
if [ "${TYPE}" != "quick" ] && [ "${TYPE}" != "full" ]; then
	print_instructions_and_exit
fi

# Shift of TYPE from ARGV
shift 1

if [ "$#" -eq 0 ]; then
	print_instructions_and_exit
fi

START_TIME=$(date +%s)

export GMVAULT_DIR="/gmvault/config"

for EMAIL in "${@}"; do
	gmvault sync \
		-t "${TYPE}" \
		-d "/gmvault/data/$(echo ${EMAIL} | tr "@" "-")" \
		"${EMAIL}"
done

echo "==== total run time: $(($(date +%s) - $START_TIME)) seconds ===="
