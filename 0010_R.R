# https://projecteuler.net/problem=10

# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.

lots_of_primes <- pracma::primes(2e6)
sum(lots_of_primes)
