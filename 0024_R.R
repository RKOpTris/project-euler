# https://projecteuler.net/problem=24

# A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
#   
#   012   021   102   120   201   210
# 
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

### creating a blank matrix

num_choices <- 1:10
num_choices_length <- length(num_choices)
full_matrix <- matrix(NA, nrow = factorial(max(num_choices)), ncol = length(num_choices))

### working out the column-wise combinations

### my pen and paper solution showed that the numbers cycle in groups of 10! divided recursively according 
### to the column being solved. so the first column runs in in 10! / 10 cycles, the second column in 
### 10! / 10 / 9 cycles, the third column in 10! / 10 / 9 / 8 cycles, omitting the number in the cycle that
### came in the preceding column. this was done until the final two columns where it became computationally
### more efficient (to be fair I didn't actually check, but it made sense) to work out the two numbers by
### row (pretty easy once the first 8 digits were there), rather than iterate through a for loop (slow in R).

### to save on computation and for the purpose of iterating in a for loop, I used numbers 1:10 rather than
### 0:9 to make indexing efficient, and then simply subtracted 1 from the 1:10 permutation. 

for(i in 1:(max(num_choices) - 2)){
  print(i)
  div_factorial <- factorial(max(num_choices))
  for(k in 1:i){
    div_factorial <- div_factorial / rev(num_choices)[k]
  }
  if(i == 1){
    full_matrix[, i] <- rep(num_choices, each = div_factorial)
  } else {
    uniques <- as.matrix(unique(full_matrix[, 1:(i - 1)]))
    next_col <- c()
    for(j in 1:nrow(uniques)){
      current_nums <- uniques[j, ]
      available_nums <- num_choices[-current_nums]
      next_col <- c(next_col, rep(available_nums, each = div_factorial))
    }
    full_matrix[, i] <- next_col
  }
}

for(i in 1:nrow(full_matrix)){
  if(i %% 2 == 0){
    full_matrix[i, max(num_choices):(max(num_choices) - 1)] <- num_choices[-full_matrix[i, 1:(max(num_choices) - 2)]]
  } else {
    full_matrix[i, (max(num_choices) - 1):max(num_choices)] <- num_choices[-full_matrix[i, 1:(max(num_choices) - 2)]]
  }
}

full_matrix[1e6, ] - 1

### this code calculates all of the 3628800 permutations and then we look at the 1-millionth row.
### though I thought I'd found a nice solution, it still took longer than the quick PE calculation
### it was meant to be. prehaps there is a way at coming about the 1-millionth with out brute-
### forcing. but at least i got the answer.

find_all_permutations <- function(nums = 3){
  stopifnot(nums >= 3)
  num_choices <- 1:nums
  num_choices_length <- length(num_choices)
  full_matrix <- matrix(NA, nrow = factorial(max(num_choices)), ncol = length(num_choices))
  for(i in 1:(max(num_choices) - 2)){
    start <- Sys.time()
    div_factorial <- factorial(max(num_choices))
    for(j in 1:i){
      div_factorial <- div_factorial / rev(num_choices)[j]
    }
    if(i == 1){
      full_matrix[, i] <- rep(num_choices, each = div_factorial)
    } else {
      uniques <- as.matrix(unique(full_matrix[, 1:(i - 1)]))
      next_col <- c()
      for(j in 1:nrow(uniques)){
        current_nums <- uniques[j, ]
        available_nums <- num_choices[-current_nums]
        next_col <- c(next_col, rep(available_nums, each = div_factorial))
      }
      full_matrix[, i] <- next_col
    }
    finish <- Sys.time()
    message(paste("Column", i, "computed in", finish - start))
  }
  
  message(paste("Computing last two columns..."))
  for(i in 1:nrow(full_matrix)){
    if(i %% 2 == 0){
      full_matrix[i, max(num_choices):(max(num_choices) - 1)] <- num_choices[-full_matrix[i, 1:(max(num_choices) - 2)]]
    } else {
      full_matrix[i, (max(num_choices) - 1):max(num_choices)] <- num_choices[-full_matrix[i, 1:(max(num_choices) - 2)]]
    }
  }
  message("Done!")
  full_matrix
  
}

find_all_permutations(8)

