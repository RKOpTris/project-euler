#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://projecteuler.net/problem=25

fib_last2 = [1, 1]
fib_max = 0
index = len(fib_last2)

while len(str(fib_max)) < 1000:
    new_max = sum(fib_last2)
    fib_last2 = [fib_last2[1], new_max]
    fib_max = new_max
    index += 1
