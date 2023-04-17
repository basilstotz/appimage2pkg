#!/bin/sh

#https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
#https://api.github.com/repos/$1/releases/latest

#echo "$1"

get_latest_release(){
    uhu=""
    if echo "$1"| grep -q -e "https://github.com/.*/releases/download/.*"; then
	api=$(echo "$1" | sed -E "s@https://github.com/(.*)/releases/download/.*@https://api.github.com/repos/\\1/releases/latest@")
	res=$(curl --silent "$api" | jq -r ".assets[].browser_download_url" 2>/dev/null | xargs)
	if test -n "$res"; then
		for r in $res; do
		    if echo "$r" | grep -q -e ".*x86_64.*AppImage"; then
			uhu="$r"
		    fi
		done
		if test -z "$uhu"; then
		    for r in $res; do
			if echo "$r" | grep -q AppImage; then
			    uhu="$r"
			fi
		    done
		fi	
	fi
	if test -n "$uhu"; then
	    echo "$uhu"
	else
	    echo "$1"
	fi
    else
	echo "$1"
    fi
}

get_latest_release "$1"


exit
