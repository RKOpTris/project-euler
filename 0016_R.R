# https://projecteuler.net/problem=16

# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
# What is the sum of the digits for the number 2^1000

atomise <- function(x, as_class = "integer"){
  y <- stringr::str_split(x, "") %>% unlist()
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

### this crashes my M1 MacBook, and used an Intel/Windows laptop
sum(atomise(gmp::as.bigz(2^1000)))