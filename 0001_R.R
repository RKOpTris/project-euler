# https://projecteuler.net/problem=1

# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
# The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

multiples_below <- function(x, n){
  lapply(n, function(i){which(1:x %% i == 0)}) %>% unlist %>% unique
}

my_solution <- function() sum(multiples_below(999, c(3, 5)))
my_solution()

### OR ###
# The solution provided by Project Euler upon solving the task:

sumDivisibleBy <- function(n, target){
  p <- floor(target / n)
  floor(0.5 * n * p * (p + 1))
}

pe_solution <- function() sumDivisibleBy(3, 999) + sumDivisibleBy(5, 999) - sumDivisibleBy(15, 999)
pe_solution()

microbenchmark::microbenchmark(my_solution(), pe_solution())

# Unit: microseconds
#          expr      min        lq       mean   median       uq      max neval cld
# my_solution() 1436.584 1442.7715 1461.31732 1446.812 1451.626 2751.918   100   b
# pe_solution()    1.375    1.4385   15.20154    1.834    2.168 1320.292   100  a 

### PE's solution is >750X faster (taking median)!
