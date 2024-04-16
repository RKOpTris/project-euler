sumDivisibleBy <- function(n, target){
  p <- floor(target / n)
  floor(0.5 * n * p * (p + 1))
}

sumDivisibleBy(3, 999) + sumDivisibleBy(5, 999) - sumDivisibleBy(15, 999)
