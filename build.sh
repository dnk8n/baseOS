#!/bin/bash

# Run this script with Arch linux's pacman installed
# Requires arch-install-scripts squashfs-tools grub parallel

## build scripts to use, will be sourced in order and in parallel
buildscripts=('build-img.sh' 'build-squashed-root.sh' 'build-user-crypt-img.sh')


serial-build() {
## source build-scripts
for a in ${buildscripts[@]}; do
  . "build-scripts/$a"
done
}

parallel-build() {
## build-user-crypt-img.sh requires user input, hence it serial
"build-scripts/build-user-crypt-img.sh"
## run build.parallel
./build.parallel build-img.sh build-squashed-root.sh
}

if [ "$1" == "-p" ]; then
   parallel-build
 else
   serial-build
fi

echo "Please read README on how to write baseOS.img to disk"
