#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# https://projecteuler.net/problem=9

stop_loop = False
n = 1000
for a in range(1, n):
  for b in range(a, n):
    for c in range(b, n):
      if a**2 + b**2 == c**2 and a + b + c == n:
        print(a * b * c)
        stop_loop = True
        break      
    
    if stop_loop:
        break
  
  if stop_loop: 
      break
