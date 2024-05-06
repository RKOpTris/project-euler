#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
https://projecteuler.net/problem=42

The nth term of the sequence of triangle numbers is given by, 
 
tn = 0.5n(n+1); so the first ten triangle numbers are:
1, 3, 6, 10, 15, 21, 28, 36, 45, 55...

By converting each letter in a word to a number corresponding to its 
alphabetical position and adding these values we form a word value. For 
example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value 
is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file 
containing nearly two-thousand common English words, how many are triangle 
words?
"""

import requests
import string
url = "https://projecteuler.net/resources/documents/0042_words.txt"
response = requests.get(url)
words = response.text.split(",")
words = [item.replace('"', '') for item in words]
keys = list(string.ascii_uppercase)
values = list(range(1, 27, 1))
alphabetVals = {k: v for k, v in zip(keys, values)}

# generate a limited list of triangle numbers to check against
triNums = []
for n in range(1, 10 * 26):
    triNums.append(0.5 * n * (n + 1))

triangleWords = 0

for i in range(0, len(words)):
    currentWord = words[i]
    wordLetters = [char for char in currentWord]
    letterValues = [alphabetVals[key] for key in wordLetters]
    if(sum(letterValues) in triNums):
        triangleWords += 1

print(triangleWords)    


