# https://projecteuler.net/problem=29

### see the link above for the decription of this task, it's a bit hard to
### represent here!

ab_grid <- expand.grid(a = 2:100, b = 2:100)
a2b_grid <- ab_grid %>% mutate(a2pb = a^b)
unique(a2b_grid$a2pb) %>% length()