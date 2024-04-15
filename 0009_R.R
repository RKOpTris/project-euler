# https://projecteuler.net/problem=9

# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2.
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
# There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the product abc.

stop_loop <- F
n <- 1000
for(a in 1:n){
  for(b in a:n){
    for(c in b:n){
      if(a^2 + b^2 == c^2 && a + b + c == n){
        print(a * b * c)
        stop_loop <- T
        break
      }
    }
    if(stop_loop){break}
  }
  if(stop_loop){break}
}
# Another problem brute-forced and it's not exactly quick! Plenty of room for improvement!
