#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
https://projecteuler.net/problem=99
"""

import requests
url = "https://projecteuler.net/resources/documents/0099_base_exp.txt"
response = requests.get(url)

lines = response.text.splitlines()

integers = [int(pair.split(',')[0]) for pair in lines]
powers = [int(pair.split(',')[1]) for pair in lines]

largestInteger = integers[0]
largestPower = powers[0]
largestIndex = 0

for i in range(len(lines) - 1):
    print(i)
    if integers[i + 1] ** powers[i + 1] > largestInteger ** largestPower:
       largestInteger =  integers[i + 1]
       largestPower =  powers[i + 1]
       largestIndex = i + 1
       
### being that this took a while for python, brute-forcing like this was
### clearly not what the problem-setters had intended ;-)  
    
print(largestIndex + 1)
