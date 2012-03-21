#!/usr/bin/perl
use strict;
use warnings;
print ((`pacman -Qu` =~ m/^[^\s]+\s\((\d+)\):/m) ? $1 : 0);