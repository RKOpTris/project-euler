# https://projecteuler.net/problem=15

# Starting in the top left corner of a 2 * 2 grid, and only being able to move to the right and down, 
# there are exactly 6 routes to the bottom right corner.
# How many such routes are there through a 20 * 20 grid?

### Going right or down is a binary choice
lattice_routes <- function(n){
  grid_size <- n
  manhattan_distance <- grid_size + grid_size
  to_permutate <- lapply(1:manhattan_distance, function(x){c(0, 1)})
  all_permutations <- expand.grid(to_permutate)
  length(which(rowSums(all_permutations) == manhattan_distance / 2))
}

for(i in 2:20){
  print(lattice_routes(i))
}
### Agh! Only makes it to n = 12 and then swallows all the memory. Need to try another way.
### After thinking it must be something to do with factorial, I couldn't work out how to account for the fact there
### are multiples of 0 and 1. I asked ChatGPT 3.5 and it said (in the conext of pebbles, the example I gave):

### "The number of permutations of 4 items where 2 items are identical (for example, 2 white pebbles) is calculated by 
### dividing the total permutations by the factorial of the number of identical items. In this case, since you have 2 
### identical white pebbles and 2 identical black pebbles, you divide by 2!*2! to eliminate the duplicate permutations"

### A pretty good (and correct!) answer, and so implemented below as a function:
lattice_routes <- function(grid_size){
  manhattan_distance <- grid_size + grid_size
  go_left <- rep(c(0, 1), length.out = manhattan_distance)
  counts <- table(go_left)
  unname(factorial(length(go_left)) / (factorial(counts[1]) * factorial(counts[2])))
}
lattice_routes(20)