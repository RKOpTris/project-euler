# https://projecteuler.net/problem=14

# The following iterative sequence is defined for the set of positive integers:
#   n -> n / 2 (n is even)
#   n -> 3n + 1 (if n is odd)
# Using the rule above and starting with 13 we generate the following sequence:
#   13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1.
# 
# It can be seen that this sequence starting at 13 and finishing at 1 contains 10 terms. 
# Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# NOTE: Once the chain starts the terms are allowed to go above one million.

collatz <- function(n){
  if(n %% 2 == 0){
    n <- n / 2
  } else {
    n <- (3 * n) + 1
  }
}

col_chain <- function(x){
  chain <- 1
  starting_number <- x
  n1 <- starting_number
  while(n1 != 1){
    n1 <- collatz(n1)
    chain <- chain + 1
  }
  chain
}

longest_collatz <- mclapply(1:1e6, col_chain)
which.max(longest_collatz)