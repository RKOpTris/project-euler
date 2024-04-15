# https://projecteuler.net/problem=4

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 
# 2-digit numbers is 9009 = 91 * 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

many_combinations <- expand.grid(n1 = 100:999, n2 = 100:999)
many_combinations <- many_combinations %>% mutate(product = n1 * n2)

str_reverse <- function(x){
  str_split(x, "") %>% unlist %>% rev %>% paste(collapse = "")
}

is_palindrome <- function(x){
  if(nchar(x) %% 2 == 0){
    first <- str_sub(x, 1, nchar(x) / 2)
    second <- str_sub(x, -(nchar(x) / 2))
  } else {
    first <- str_sub(x, 1, (nchar(x) - 1) / 2)
    second <- str_sub(x, -((nchar(x) - 1) / 2))
  }
  second <- str_reverse(second)
  first == second
}

many_combinations$is_palindrome <- sapply(many_combinations$product, is_palindrome) %>% unlist()

many_combinations %>% filter(is_palindrome) %>% summarise(max(product))
