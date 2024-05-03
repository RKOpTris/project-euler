# https://projecteuler.net/problem=43

### See the link above for the problem

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

div_by <- function(x, cols, divisor){
  x <- x[, cols]
  parallel::mclapply(1:nrow(x), function(r){
    num <- paste(x[r, ], collapse = "") %>% as.integer()
    num %% divisor == 0
  }) %>% unlist()
}

fuse <- function(x, as_class = NULL){
  y <- paste0(x, collapse = "")
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

full_matrix <- find_all_permutations(10)
full_matrix <- full_matrix - 1
first_primes <- pracma::primes(17)

for(i in 1:length(first_primes)){
  div <- div_by(full_matrix, (i + 1):(i + 3), first_primes[i])
  full_matrix <- full_matrix[div, ]
}

apply(full_matrix, 1 , fuse) %>% sum()
