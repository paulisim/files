#!/usr/bin/env bash
#
# List unmerged packages which are found in package.* files
#

for f in /etc/portage/package.*/*; do
	for p in $(cat ${f} | awk '/^[a-z]/ {print $1}'); do
		if [[ -z "$(qlist -IC $p)" ]]; then
			p_prefix="${p##=}"
			p_suffix="${p_prefix%%::*}"
			p_version="${p_suffix%%-[0-9]*}"
			echo -en "\033[0;36m${f##*portage/} -> \033[0;34m${p_version}\n\033[0;30m"
		fi
	done
done
