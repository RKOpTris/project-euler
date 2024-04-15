# https://projecteuler.net/problem=3

# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143?
my_factors <- pracma::factors(600851475143)
are_factors <- my_factors[as.logical(pracma::isprime(my_factors))]
max(are_factors)