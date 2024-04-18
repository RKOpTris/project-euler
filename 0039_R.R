# https://projecteuler.net/problem=39

# If p is the perimeter of a right angle triangle with integral length sides, {a, b, c}, 
# there are exactly three solutions for p = 120.
# 
# {20, 48, 52}, {24, 45, 51}, {30, 40, 50}
# 
# For which value of p less than 1000, is the number of solutions maximised?

n_integral_solutions <- function(p){
  abc <- data.frame()
  for(a in 1:p){
    for(b in a:p){
      for(c in b:p){
        if(a^2 + b^2 == c^2 && a + b + c == p){
          abc <- rbind(abc, data.frame(a = a, b = b, c = c))
        }
      }
    }
  }
  apply(abc, 1, sort) %>% t %>% data.frame %>% unique %>% nrow
}

for(i in 1:1000){
  print(i)
  n_solutions[i] <- n_integral_solutions(i)
}

length(n_solutions)
max(n_solutions)
which.max(n_solutions)

### BRUTE-FORCED :-/