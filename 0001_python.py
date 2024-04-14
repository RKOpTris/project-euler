#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#1
vals = []
n = 3

while n < 1000:
    if n % 3 == 0 or n % 5 == 0:
        vals.append(n)
        
    n += 1
    
print(sum(vals))