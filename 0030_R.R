# https://projecteuler.net/problem=30

# best see the description of this problem using the link above

find_sum_of_powers <- function(p, i_start = 2, i_max = 1e6){
  sum_of_powers <- c()
  i <- i_start
  while(i <= i_max){
    if(i == as.integer(i) %>% atomise() %>% `^`(p) %>% sum()){
      sum_of_powers <- c(sum_of_powers, i)
    }
    i <- i + 1
  }
  sum(sum_of_powers)
}

find_sum_of_powers(5)

### the problem is, I don't know why this is right! so almost a lucky answer 
### because I don't know what the theoretical maximum should be - it just
### happened that it was under 1e6
