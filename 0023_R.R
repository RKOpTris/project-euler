# https://projecteuler.net/problem=23

# A perfect number is a number for which the sum of its proper divisors is exactly 
# equal to the number. For example, the sum of the proper divisors of 28 would be 
# 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
# 
# A number n is called deficient if the sum of its proper divisors is less than 
# n and it is called abundant if this sum exceeds n.
# 
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number 
# that can be written as the sum of two abundant numbers is 24. By mathematical 
# analysis, it can be shown that all integers greater than 28123 can be written as 
# the sum of two abundant numbers. However, this upper limit cannot be reduced any 
# further by analysis even though it is known that the greatest number that cannot 
# be expressed as the sum of two abundant numbers is less than this limit.
# 
# Find the sum of all the positive integers which cannot be written as the sum of 
# two abundant numbers.

### Working with R here, it doesn't do very well in term of memory when adding to a vector of undefined length.
### Here they are defined in advance to help the algo perform more efficiently.

all_abundant_above <- 28123

is_abundant <- function(x){
  divs <- RcppAlgos::divisorsRcpp(x)
  divs <- divs[-length(divs)]
  sum(divs) > x
}

i <- 1
abundant <- logical(all_abundant_above)
while(i <= all_abundant_above){
  abundant[i] <- is_abundant(i)
  i <- i + 1
}
abundant_nos <- (1:all_abundant_above)[abundant]
abundantSums <- expand.grid(abundant_nos, abundant_nos) %>% as.matrix() %>% rowSums
abundantSums <- abundantSums %>% unique
sum(which(!1:all_abundant_above %in% abundantSums))