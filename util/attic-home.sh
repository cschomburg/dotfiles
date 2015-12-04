#!/bin/sh

ATTIC=/run/current-system/sw/bin/attic

$ATTIC create --stats -v \
	~/sync/attic::`date +%Y-%m-%d` \
	~ \
	--exclude ~/sync \
	--exclude ~/backup \
	--exclude ~/downloads \
	--exclude ~/jail/downloads \
	--exclude ~/jail/Downloads \
	--exclude ~/VirtualBox\ VMs \
	--exclude ~/.vagrant.d/boxes

$ATTIC prune ~/sync/attic --keep-within=10d --keep-weekly=4 --keep-monthly=-1
