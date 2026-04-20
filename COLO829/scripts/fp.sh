#!/bin/bash

for i in 2 3 4 5; do
    python fdr.py 1 "$i";
done

for i in 1 3 4 5; do
    python fdr.py 2 "$i";
done

for i in 1 2 4 5; do
    python fdr.py 3 "$i";
done

for i in 1 2 3 5; do
    python fdr.py 4 "$i";
done

for i in 1 2 3 4; do
    python fdr.py 5 "$i";
done

