# https://projecteuler.net/problem=7

# By listing the first six prime numbers: 
# 2, 3, 5, 7, 11, and 13, 
# we can see that the 6th prime is 13.
# 
# What is the 10001st prime number?

i <- 1
my_primes <- integer()
while(length(my_primes) < 10002){
  i <- i * 10
  my_primes <- as.integer(pracma::primes(i))
}
my_primes[10001]