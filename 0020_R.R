# https://projecteuler.net/problem=20

# n! means n * (n - 1) * ... * 3 * 2 * 1.
# For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800, and the sum of the digits in the number 
# 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
# Find the sum of the digits in the number 100!

### For some reason gmp::bigz(factorial(100)) gives a different 100! (...?!?!)  .
### I calculated it in Python using maths.factorial(100) and cut and paste it into R :-/
### Not technically an R solution!
### atomise() is a function I defined in earlier Project Euler solutions (and is often used)

factorial_100 <- "93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000"
atomise(factorial_100) %>% sum()