#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://projecteuler.net/problem=6

sum_of_squares = sum([i ** 2 for i in range(101)])
square_of_sum = sum([i for i in range(101)]) ** 2
print(square_of_sum - sum_of_squares)
