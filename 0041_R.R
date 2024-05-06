# https://projecteuler.net/problem=41

# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to 
# n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
# 
# What is the largest n-digit pandigital prime that exists?

fuse <- function(x, as_class = NULL){
  y <- paste0(x, collapse = "")
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

first_primes <- pracma::primes(17)

solution <- NULL

for(i in 9:4){
  
  # find permutations
  full_matrix <- do.call(rbind, combinat::permn(1:i))
  
  # fuse digits into n-digit integers
  pandigital_numbers <- apply(full_matrix, 1, fuse) %>% sort()
  
  # reverse the order to find highest prime first (if applicable)
  pandigital_numbers <- rev(pandigital_numbers)
  
  # check if permuted numbers are divisible (and therefore not prime)
  for(j in 1:length(first_primes)){
    pandigital_numbers <- pandigital_numbers[!(pandigital_numbers %% first_primes[j] == 0)]
  }
  if(length(pandigital_numbers) == 0){
    next
  } else {
    it_is_prime <- F
    j <- 0
    while(!it_is_prime){
      j <- j + 1
      if(pracma::isprime(pandigital_numbers[j])){
        it_is_prime <- T
      }
    }
    solution <- pandigital_numbers[j]
  }
  if(!is.null(solution)){
    print(solution)
    break
  }
}
