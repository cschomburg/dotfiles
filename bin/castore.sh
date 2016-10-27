#!/usr/bin/env bash

set -eu

calc_key () {
	file="$1"
	extension="${file##*.}"
	checksum=$(sha256sum "$file" | cut -d' ' -f 1)
	size=$(stat -c%s "$file")
	fullkey="SHA256E-s$size--$checksum.$extension"
	echo "$fullkey"
}

dir_key() {
	fullkey="$1"
	dirhash=$(echo -n $fullkey | md5sum | cut -d' ' -f 1)
	d1=${dirhash:0:3}
	d2=${dirhash:3:3}
	echo "$d1/$d2/$fullkey/$fullkey"
}

mv_file () {
	prefix=$1
	src="$2"
	if [ ! -f "$src" ]; then
		return 1
	fi
	if [ -h "$src" ]; then
		return 1
	fi


	key=$(calc_key "$src")
	dst=$1/$(dir_key "$key")

	mkdir -p $(dirname $dst)
	mv "$src" "$dst"
	ln -sr "$dst" "$src"
	echo -e "$key\t$src" >> $1/cas.txt
}

mv_file "$1" "$2"
