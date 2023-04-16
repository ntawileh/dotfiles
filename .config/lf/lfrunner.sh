#!/usr/bin/env bash

#env
#echo $1

mime=$(file --mime-type -b $fx)

case "$mime" in
 text/*) $EDITOR "$fx";;
 *) for f in $fx; do open "$f" > /dev/null 2> /dev/null & done;;

esac
