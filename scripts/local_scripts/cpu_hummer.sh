#!/bin/sh

# unixfoo.blogspot.com

if [ $1 ]; then
    NUM_PROC=$1
else
    NUM_PROC=10
fi

for i in `seq 0 $((NUM_PROC-1))`; do
    awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<100000;j++);}' &
done