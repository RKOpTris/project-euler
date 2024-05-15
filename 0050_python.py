#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
https://projecteuler.net/problem=50
"""

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
primeSeq = sieveOfEratosthenes(int(1e6))

### the largest prime is 999983
### 20 equivalently sized numbers would have to be ~50000 so should not search
### for vales any higher than that (20 consecutive numbers = 983 prime below
### 1000, if the prime nearest 1e6 exceeeds the number of primes <1000. That
### is an assumption.
### the search should start at 21 primes to ensure 1000 is not the highest
### number of summable consecutive primes.
### could brute-force:
    
### the number of primes increases iteratively until a new prime sum is found
### or the sum of the primes exceeds 1e6
### but that is assuming that a larger prime can be found with a larger number
### of primes for each allowed number of primes

### it must be an odd number of primes as an equal number of primes would
### give an even number IF 2 is not one of the primes. maybe it would be a good 
### idea to check the highest prime that can be achieved from a starting point
### of two IN WHICH CASE AN ODD NUMBER OF PRIMES SHOULD BE CHECKED

# numberOfPrimes = 21

### if first prime == 2 (even number), then starting iteration is 2 and 
### increases by 2 at each iteration

numberOfPrimes = 0
highestPrime = 0
consituentPrimes = []
maxLimit = 1000000
currentIteration = 2
while currentIteration < maxLimit: # something more like repeat?
    currentIteration += 2
    print(currentIteration)
    evalNum = sum(primeSeq[0:currentIteration])

    if evalNum > maxLimit:
        print("maxLimit exceeded! Stopping...")
        break
    if evalNum in primeSeq:
        primesList = primeSeq[0:currentIteration]
        print(evalNum)
        if len(primesList) > numberOfPrimes:
            highestPrime = evalNum
            numberOfPrimes = len(primesList)
            constituentPrimes = primesList
        
print("Number of primes:")        
print(len(constituentPrimes))
print(numberOfPrimes)
print("Maximium prime under 1e6:")
print(sum(constituentPrimes))
print(highestPrime)

### so from that we learn that primeSeq[0:536] = 958577
### that's a lot of primes! and the lowest number of primes that we are 
### looking for. we found a continuous sequence from the first prime, 2, and
### now we can see from prime 3, 5, etc. We can do this by excluding, 
### iteratively, the first prime from the primeSeq

### so we can now look at the primes from 3 of length at least 536 and they
### must not sum to over 1000 (of course)

### primeSeq[536] is 3877, and there are definitely a few extra numbers we could 
### fit in from 958577 to 1000000 but not more than 10. so the number is 
### between 536 and 546

primeSeqOdd = primeSeq[1:len(primeSeq)]
for i in range(1, 10):
    primeSeqOdd = primeSeqOdd[1:len(primeSeqOdd)]

    currentIteration = 1
    while currentIteration < maxLimit: # something more like repeat?
        currentIteration += 2
        #print(currentIteration)
        evalNum = sum(primeSeqOdd[0:currentIteration])
    
        if evalNum > maxLimit:
            print("maxLimit exceeded! Stopping...")
            break
        if evalNum in primeSeqOdd:
            primesList = primeSeqOdd[0:currentIteration]
            print(evalNum)
            if len(primesList) > numberOfPrimes:
                highestPrime = evalNum
                numberOfPrimes = len(primesList)
                constituentPrimes = primesList
        
print("Number of primes:")        
print(numberOfPrimes)
print("Maximium prime under 1e6:")
print(highestPrime)