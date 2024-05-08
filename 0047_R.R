# https://projecteuler.net/problem=47
# 
# The first two consecutive numbers to have two distinct prime factors are:
# 14 = 2 * 7
# 15 = 3 * 5.
#
# The first three consecutive numbers to have three distinct prime factors are:
# 644	= 2^2 * 7 * 23
# 645	= 3 * 5 * 43
# 646	= 2 * 17 * 19.
#
# Find the first four consecutive integers to have four distinct prime factors 
# each. What is the first of these numbers?

first_n_consecutive_prime_factors <- function(digits, max_digits){
  max_num <- rep(9, max_digits) %>% paste(collapse = "") %>% as.numeric
  factors_list <- parallel::mclapply(1:max_num, pracma::factors)
  names(factors_list) <- as.character(1:max_num)
  target_prime_factors <- parallel::mclapply(factors_list, function(x){length(unique(x)) == digits}) %>% unlist
  with_prime_factors <- strip_non_numbers(names(which(target_prime_factors == T)))
  solution_found <- F
  out <- NA
  i <- 0
  while(!solution_found && i < length(with_prime_factors) - digits - 1){
    i <- i + 1
    if(with_prime_factors[i + digits - 1] - with_prime_factors[i] == digits - 1){
      solution_found <- T
      out <- with_prime_factors[i]
    } else {
      out <- NA
    }
  }
  return(out)
}

global_max_digits <- 6
global_solution_found <- F
while(!global_solution_found){
  with_max_digits <- first_n_consecutive_prime_factors(4, global_max_digits)
  if(is.na(with_max_digits)){
    global_max_digits <<- global_max_digits + 1
  } else {
    global_solution_found <<- T
    out <- with_max_digits
  }
  print(out)
}

### not the best solution as all possibilities up to 999999 are explored and then the 
### smallest integer extracted from those results. also, all primes from 1 were calculated
### when it would have been more efficient to calculate from, say, 100000, but I used the
### convenience of the names of the lists/vectors. it would be better as a for loop but
### these are notoriously slow in R so the temptation is to calculate vectors-worth of
### data using lapply/parallel::mclapply. it is the while loop that takes time.

### definitely a brute-force solution that could be greatly improved


