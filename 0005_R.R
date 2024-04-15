# https://projecteuler.net/problem=5

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

### All numbers 1:10 are factors of 11:20 therefore search is only necessary for 11:20, not 1:20.
### 20 is the highest number and the least divisible and therefore tests of divisibility will involve
### testing numbers (n) at i * 20 increments. 

div_test <- seq(19, 11, by = -1)
i <- 0
repeat{
  i <- i + 1
  n <- i * 20
  if(sum(sapply(div_test, function(x){n %% x == 0})) == length(div_test)){
    print(n)
    break
  }
}

### This solution is just brute forcing the problem so can/will definitely be improved! It searched for divisors 11 to 19
### because n moves in 20s and all numbers <= 10 are divisible by numbers 11:20
### To possibly make the search more efficient could testing iteratively from 19:11 where the first non-zero modulo 
### will move the loop to the next value of i * 20. It did take a little while to find the solution.