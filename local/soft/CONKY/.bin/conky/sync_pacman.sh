#!/bin/sh

fakedb=/dev/shm/fakepacdb
realdb=/var/lib/pacman

[[ ! -d $fakedb ]] && { mkdir -p "$fakedb/sync" || exit 1; }
[[ ! -L $fakedb/local ]] && { ln -s "$realdb/local" "$fakedb" || exit 2; }

exec fakeroot pacman --dbpath "$fakedb" -Sy
