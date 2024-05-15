#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
https://projecteuler.net/problem=49

The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases 
by 3330 is unusual in two ways: (i) each of the three terms are prime, and, 
(ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 
1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 
4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this 
sequence?
"""
import itertools

def sieveOfEratosthenes(limit):
    primes = []
    sieve = [True] * (limit + 1)
    sieve[0] = sieve[1] = False
    
    for num in range(2, int(limit ** 0.5) + 1):
        if sieve[num]:
            primes.append(num)
            for multiple in range(num * num, limit + 1, num):
                sieve[multiple] = False
                
    for num in range(int(limit ** 0.5) + 1, limit + 1):
        if sieve[num]:
            primes.append(num)
            
    return primes

# generate list of 4-digit prime numbers
primeSeq = sieveOfEratosthenes(9999)
primeSeq = [prime for prime in primeSeq if prime > 1000]

notEnoughPerms = []
candidatePerms = []

for currPrime in primeSeq:
    savePrime = currPrime
    currPrime = list(str(currPrime))
    permNums = list(itertools.permutations(currPrime))    
    
    # filter: permutations must be unique (in the case of multiple shared digits)
    # filter: permutations must be over 1000
    # filter: permutations must be prime
    # filter: all permutations must be equal or higher than the prime
    # if resultant filtering number of permutations is < 3:
        # remove all those primes(permutations) from the candidate list of primes
        # go to next prime in list
    
    numChars = []
    for num in permNums:
        joinedNum = int(''.join(num))
        numChars.append(joinedNum)
        
    numChars = list(set(numChars))
    numOver1000 = [num for num in numChars if num > 1000]
    numPrimes = [num for num in numOver1000 if num in primeSeq]
    numPrimes = [num for num in numPrimes if num >= savePrime]
    if len(numPrimes) > 2:
        candidatePerms.append(sorted(numPrimes))

multiplesFound = 0
basePrime = []
basePrimeSeq = []

iteration = 0
while multiplesFound < 2:    
    
    testVec = candidatePerms[iteration]
    diffVec = []
    
    for prime in testVec:
        diffVec.append(prime - testVec[0])
     
    diffVec = diffVec[1:len(diffVec)]  

    for diff in diffVec:
        for anotherDiff in diffVec:
            if anotherDiff / diff == 2:
                if testVec[0] not in basePrime:
                    multiplesFound += 1
                    basePrime.append(testVec[0])
                    basePrimeSeq.append(diff)
    
    iteration += 1

knownPrimeIndex = basePrime.index(1487)
basePrime.pop(knownPrimeIndex)
basePrimeSeq.pop(knownPrimeIndex)
print("The base prime: " + str(int(basePrime[0])))
print("The addition interval: " + str(int(basePrimeSeq[0])))
print("This is the same interval for the sequence from 1487!")
part2 = 2969 + 3330
print(part2)
part3 = 2969 + 3330 + 3330
print(part3)
print(str(int(basePrime[0])) + str(part2) + str(part3))




