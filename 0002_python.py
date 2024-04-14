#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://projecteuler.net/problem=2

div2 = []
fib_nums = [1, 1]
fib_max = 0

while fib_max < 4e6:
    new_num = sum(fib_nums)
    fib_max = new_num
    if new_num % 2 ==0:
        div2.append(new_num)
    
    fib_nums = [fib_nums[1], sum(fib_nums)] 
    
print(div2)
print(sum(div2))

