# https://projecteuler.net/problem=36

# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.
# 
# Find the sum of all numbers, less than one million, which are palindromic in 
# base 10 and base 2.
# 
# (Please note that the palindromic number, in either base, may not include leading zeros.)

fuse <- function(x, as_class = NULL){
  y <- paste0(x, collapse = "")
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

defuse <- function(x, as_class = NULL){
  y <- stringr::str_split(x, "") %>% unlist()
  if(is.null(as_class)){
    as_class <- class(x)
  }
  eval(parse(text = paste0("as.", as_class, "(y)")))
}

digs1 <- 1:9
digs2 <- paste0(ones, ones)
tens <- 10:99
tens_mat <- do.call(rbind, lapply(tens, defuse))
digs3 <- cbind(tens_mat, tens_mat[, 1]) %>% apply(1, fuse)
digs4 <- cbind(tens_mat, tens_mat[, 2:1]) %>% apply(1, fuse)
hundreds <- 100:999
hundreds_mat <- do.call(rbind, lapply(hundreds, defuse))
digs5 <- cbind(hundreds_mat, hundreds_mat[, 2:1]) %>% apply(1, fuse)
digs6 <- cbind(hundreds_mat, hundreds_mat[, 3:1]) %>% apply(1, fuse)
palindromes_base10 <- c(digs1, digs2, digs3, digs4, digs5, digs6)
  
###  binary
base2_equivs <- t(matrix(as.integer(intToBits(palindromes_base10)), nrow = 32))
base2_equivs <- base2_equivs[, ncol(base2_equivs):1] %>% t %>% data.frame
base2_fused <- lapply(base2_equivs, fuse, as_class = "character")

### r is no good at handling large numbers, so have to test if palidromic by treating as character
### as.bigz crashes my m1 macbook :-/
noLeadingZeros <- function(x){
  atomised <- defuse(x)
  while(atomised[1] == 0){
    atomised <- atomised[-1]
  }
  fuse(atomised, as_class = "character")
}
base2_cleaned <- lapply(base2_fused, noLeadingZeros)
palindromic_base2 <- sapply(base2_cleaned, function(x){all(defuse(x) == rev(defuse(x)))}) %>% which()
palindromes_base10[palindromic_base2] %>%
  as.numeric %>%
  sum
