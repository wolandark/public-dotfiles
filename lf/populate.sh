#!/usr/bin/env bash 

mkdir -p Parent-{0..10}/Child-{11..21}

for f in Parent-{0..10}/Child-{11..21}/{1..10}.txt;do 
    echo "$RANDOM" > "$f";
done




