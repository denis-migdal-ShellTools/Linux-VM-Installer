function dry-run() {
	FIRST=true
	for ARG in "$@" ; do  

		if $FIRST ; then
			FIRST=false
			echo -n $'\e[33m'"$ARG"$'\e[0m'
		else
			ARG=$(echo -n "$ARG" |  perl -CSD -pe 's/(\P{Print})/sprintf("\e[3m<0x%02X>\e[0;4;36m", ord($1))/ge' )
			# | sed -z 's/[^[:print:]]/�/g'
			#
			# | perl -pe 's/([^\x20-\x7E])/sprintf("\e[3m<0x%02X>\e[0;4;34m", ord($1))/ge')
			echo -n " "$'\e[4;36m'"$ARG"$'\e[0m'
		fi

		#echo -n "$ARG"
		#PARSED=$(printf '%q' "$ARG")
		#if [[ "$PARSED" == "$ARG" ]] ; then
		#	printf "%s" "$ARG"
		#else
		#	printf "'%s'" "$ARG"
		#fi
	done

	echo ""

	ORIG_CMDLINE="$(history|tail -n 1| sed 's/^ *[0-9]*[[:space:]]*'${FUNCNAME[0]}' *//')";

	history -s "$ORIG_CMDLINE" # $@
}