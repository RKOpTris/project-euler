# https://projecteuler.net/problem=54

# In the card game poker, a hand consists of five cards and are ranked, from 
# lowest to highest, in the following way:
#   
# High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# 
# The cards are valued in the order:
#   2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
# 
# If two players have the same ranked hands then the rank made up of the highest 
# value wins; for example, a pair of eights beats a pair of fives (see example 1 
# below). But if two ranks tie, for example, both players have a pair of queens, 
# then highest cards in each hand are compared (see example 4 below); if the 
# highest cards tie then the next highest cards are compared, and so on.

### some examples of hands/wins/scores see website above

hands <- read.table("0054_poker.txt")

### convert the letters to numeric values to compare scores
hands <- lapply(hands, function(x){
  x %>% 
    str_replace_all("T", "10") %>%
    str_replace_all("J", "11") %>%
    str_replace_all("Q", "12") %>%
    str_replace_all("K", "13") %>%
    str_replace_all("A", "14")
}) %>% data.frame()


p1 <- hands[1:5]
p2 <- hands[-(1:5)]

### defining score check functions
check_royal_flush <- function(x){
  y <- sapply(x, str_replace_all, "[^A-Z]", "")
  if(length(table(y)) == 1){
    values <- sort(as.numeric(sapply(x, str_replace_all, "[A-Z]", "")))
    ifelse(sum(values) == sum(10:14), sum(values), NA)
  } else {
    NA
  }  
}

check_straight_flush <- function(x){
  y <- sapply(x, str_replace_all, "[^A-Z]", "")
  if(length(table(y)) == 1){
    values <- sort(as.numeric(sapply(x, str_replace_all, "[A-Z]", "")))
    if(length(unique(diff(values))) == 1 && unique(diff(values)) == "1"){
      sum(values)
    } else {
      NA 
    }
  } else {
    NA
  }  
}

check_four_of_a_kind <- function(x){
  y <- sapply(x, strip_non_numbers) %>% table
  if(any(y == 4)){
    as.numeric(names(which(y == 4))) * 4
  } else {
    NA
  }
}

check_full_house <- function(x){
  y <- sapply(x, strip_non_numbers) %>% table
  if(all(2:3 %in% y)){
    as.numeric(names(which(y == 3))) * 3 + as.numeric(names(which(y == 2))) * 2
  } else {
    NA
  }
}

check_flush <- function(x){
  y <- sapply(x, str_replace_all, "[^A-Z]", "")
  if(length(table(y)) == 1){
    sum(as.numeric(sapply(x, str_replace_all, "[A-Z]", "")))
  } else {
    NA
  }
}

check_straight <- function(x){
  values <- sort(as.numeric(sapply(x, str_replace_all, "[A-Z]", "")))
  if(length(unique(diff(values))) == 1 && unique(diff(values)) == "1"){
    sum(values)
  } else {
    NA
  }
}

check_three_of_a_kind <- function(x){
  y <- sapply(x, strip_non_numbers) %>% table
  if(any(y == 3)){
    as.numeric(names(which(y == 3))) * 3
  } else {
    NA
  }
}

check_two_pairs <- function(x){
  y <- sapply(x, strip_non_numbers) %>% table
  if(sum(y == 2) == 2){
    names(y[y == 2]) %>% as.numeric %>% `*`(2) %>% sum
  } else {
    NA
  }
}

check_one_pair <- function(x){
  y <- sapply(x, strip_non_numbers) %>% table
  if(sum(y == 2) == 1){
    names(y[y == 2]) %>% as.numeric %>% `*`(2) %>% sum
  } else {
    NA
  }
}

check_high_card <- function(x){
  sapply(x, strip_non_numbers) %>% max
}

#### to check heirarchy of wins from royal flush (best win) to highest card (lowest)
check_list <- list(check_royal_flush,
                   check_straight_flush,
                   check_four_of_a_kind,
                   check_full_house,
                   check_flush,
                   check_straight,
                   check_three_of_a_kind,
                   check_two_pairs,
                   check_one_pair,
                   check_high_card
)

### store functions in a list and iterate until returns TRUE using this fun
find_best_score <- function(x){
  out <- NA
  fun <- 1
  test_score <- 10
  while(is.na(out)){
    out <- check_list[[fun]](x)
    fun <- fun + 1
    test_score <- test_score - 1
  }
  data.frame(win_condition = test_score,
             score = out)
}

### scoring each player
p1_results <- do.call(rbind, lapply(1:nrow(p1), function(r) find_best_score(p1[r, ])))
p2_results <- do.call(rbind, lapply(1:nrow(p2), function(r) find_best_score(p2[r, ])))

### combining scores
names(p1_results) <- c("p1_win_condition", "p1_score")
names(p2_results) <- c("p2_win_condition", "p2_score")
all_results <- bind_cols(p1_results, p2_results)

### for outright wins
outright_wins <- all_results %>% 
  filter(p1_win_condition > p2_win_condition) %>% 
  count()

### when win condition draw, check score
down_to_score <- all_results %>% 
  filter(p1_win_condition == p2_win_condition) %>%
  filter(p1_score > p2_score) %>%
  count()   

### the answer
sum(outright_wins, down_to_score)


