# https://projecteuler.net/problem=32

# We shall say that an n-digit number is pandigital if it makes use of all the digits 
# 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5
# pandigital.
# 
# The product 7254 is unusual, as the identity, 39 * 186 = 7254, containing 
# multiplicand, multiplier, and product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity can be 
# written as a 1 through 9 pandigital.
# 
# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

pandigitals <- combinat::permn(1:9)

fuse <- function(x, as_class = NULL){
  y <- paste0(x, collapse = "")
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

pandigitals <- mclapply(pandigitals, fuse)

### with 2-digit integer * 3-digit integer
products <- pandigitals |> str_sub(-4) |> as.integer()
multiplicands <- pandigitals |> str_sub(1, 2) |> as.integer()
multipliers <- pandigitals |> str_sub(3, 5) |> as.integer()
multis <- cbind(multiplicands, multipliers)
actProds <- matrixStats::rowProds(multis)
pandigitalProducts1 <- products[which(actProds == products)]

### with 1-digit integer * 4-digit integer
products <- pandigitals |> str_sub(-4) |> as.integer()
multiplicands <- pandigitals |> str_sub(1, 1) |> as.integer()
multipliers <- pandigitals |> str_sub(2, 5) |> as.integer()
multis <- cbind(multiplicands, multipliers)
actProds <- matrixStats::rowProds(multis)
(pandigitalProducts2 <- products[which(actProds == products)])

c(pandigitalProducts1, pandigitalProducts2) |> unique() |> sum()

