# https://projecteuler.net/problem=21

### See the description of this task at the website above

divisors_non_self <- function(x){
  divs <- RcppAlgos::divisorsRcpp(x)
  divs[-length(divs)]
}

give_amicable <- function(x){
  other <- sum(divisors_non_self(x))
  if(sum(divisors_non_self(other)) == x && other != x){
    other
  } else {
    NA
  }
}

are_amicable <- sapply(1:10000, give_amicable)
sum(are_amicable[complete.cases(are_amicable)])