# https://projecteuler.net/problem=28

# see the description of this challenge in the link above

spiral_seq <- seq(3, 1001, by = 2)

spiral_diagonals <- function(x){
  n1 <- x^2
  n2 <- n1 - (x - 1)
  n3 <- n2 - (x - 1)
  n4 <- n3 - (x - 1)
  matrix(c(n1, n2, n3, n4), nrow = 1)
}

all_diagonals <- mclapply(spiral_seq, spiral_diagonals)
sum(do.call(rbind, all_diagonals)) + 1 ### adding 1 is easier than altering the function/calculation to accommodate 1

### OR (244 microseconds, or 60X faster than the previous solution):

spiral_seq <- seq(3, 1001, by = 2)
1 + do.call(rbind, lapply(0:3, function(x){ spiral_seq^2 - (x * (spiral_seq - 1)) })) %>% sum
