#!/bin/bash

# create the read only squashed root


## set the user specified packages from squashed-packages.txt
packages=()
while read -r; do
  packages+=($REPLY)
done < squashed-packages.txt

## requires arch-install-scripts pacman
## install arch linux to a directory
mkdir baseOS-squashed-root
pacstrap -C pacman.conf -d baseOS-squashed-root base ${packages[@]}

## copy baseOS-squashfs hooks to the new arch linux install
cp initcpio-hooks/hooks/squashfs baseOS-squashed-root/usr/lib/initcpio/hooks/
cp initcpio-hooks/install/squashfs baseOS-squashed-root/usr/lib/initcpio/install/

## copy mkinitcpio.conf to the new arch linux install
cp mkinitcpio.conf baseOS-squashed-root/etc/

## rebuild initramfs in the new arch linux install
pacstrap -C pacman.conf -d baseOS-squashed-root linux

## squash the baseOS directory
mksquashfs baseOS-squashed-root baseOS.sqsh
