#!/bin/sh

case "$2" in
	git)
		cd $1;git config --file config http.receivepack true
	;;

	*)
	;;
esac
