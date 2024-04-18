# https://projecteuler.net/problem=22

# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing 
# over five-thousand first names, begin by sorting it into alphabetical order. 
# Then working out the alphabetical value for each name, multiply this value by its 
# alphabetical position in the list to obtain a name score.
# 
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 
# 3 _ 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score 
# of 938 * 53 = 49714.
# 
# What is the total of all the name scores in the file?

ep_names <- readLines("0022_names.txt")
ep_names <- ep_names %>% str_split(",") %>% unlist %>% str_replace_all("[^A-Z]", "") %>% sort
letter_sum <- mclapply(1:length(ep_names), function(x){
  a_name <- ep_names[x] %>% atomise("character")
  sapply(a_name, function(x){which(LETTERS %in% x)}) %>% sum
}) %>% unlist
total_scores <- sapply(1:length(letter_sum), function(x){x * letter_sum[x]})
sum(total_scores)