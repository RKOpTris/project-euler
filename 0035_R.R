# https://projecteuler.net/problem=35

# The number, 197, is called a circular prime because all rotations of the digits: 
# 197, 971, and 719, are themselves prime.
# 
# There are thirteen such primes below 100: 
# 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
# 
# How many circular primes are there below one million?

rotateVector <- function(x){
  x[c(2:length(x), 1)]
}

defuse <- function(x, as_class = NULL){
  y <- stringr::str_split(x, "") %>% unlist()
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

primesVector <- pracma::primes(1e6)
circularPrimes <- c()
for(prime in primesVector){
  atomised <- defuse(prime)
  rotating <- atomised
  rotations <- prime
  if(length(atomised) > 1){
    for(i in 1:(length(atomised) - 1)){
      rotating <- rotateVector(rotating)
      rotations <- c(rotations, fuse(rotating))
    }
  }
  primeCount <- 0
  for(r in rotations){
    if(!pracma::isprime(r)){
      next
    } else {
      primeCount <- primeCount + 1
    }
  }
  if(primeCount == length(rotations)){
    circularPrimes <- c(circularPrimes, prime)
  }
}
length(unique(circularPrimes))

### i could make this faster by testing for primes before performing another rotation




