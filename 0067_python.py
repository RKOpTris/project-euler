#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
https://projecteuler.net/problem=67
"""
# test data in example, total is 23
# pyramid = [[3],
#           [7, 4],
#           [2, 4, 6],
#           [8, 5, 9, 3]]

import requests
url = "https://projecteuler.net/resources/documents/0067_triangle.txt"
response = requests.get(url)

lines = response.text.splitlines()
pyramid = [line.strip() for line in lines]
for i in range(len(pyramid)):
    numString = pyramid[i].split()
    pyramid[i] = [int(number) for number in numString]

finalValue = pyramid[0]
pyramid = list(reversed(pyramid))
 
while len(pyramid) > 1:
    sumRowLower = pyramid[0]
    sumRowUpper = pyramid[1]
    newRow = []
    for i in range(len(sumRowUpper)):
        tempTotal = []
        for j in range(2):
            tempTotal.append(sumRowUpper[i] + sumRowLower[i + j])           
        tempTotal = max(tempTotal)
        newRow.append(tempTotal)
    print(newRow)
    pyramid = pyramid[1:len(pyramid)]
    pyramid[0] = newRow

print(pyramid[0][0])


 
    
    