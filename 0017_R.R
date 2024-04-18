# https://projecteuler.net/problem=17

# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then 
# there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, 
# how many letters would be used?
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) 
# contains  23 letters and 115 (one hundred and fifteen) contains 20 letters. 
# The use of "and" when writing out numbers is in compliance with British usage.

num_words <- data.frame(tens = c(NA, "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety", rep(NA, 10)), ones = c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"))

number_as_text <- function(number){
  last_two <- as.numeric(str_sub(number, -2))
  if(nchar(number) >= 2 && last_two < 20){
    last_two <- num_words$ones[last_two]
  } else if(nchar(number) >= 2 && last_two >= 20){
    digits <- last_two %>% str_split("") %>% unlist() %>% as.numeric()
    last_two <- paste0(num_words$tens[digits[1]], "-", num_words$ones[digits[2]])
  } else {
    last_two <- num_words$ones[as.numeric(number)]
  }
  hundred_text <- ""
  if(nchar(number) > 2){
    hundred <- as.numeric(str_sub(number, 1, 1))
    hundred_text <- paste0(num_words$ones[hundred], " hundred") 
    if(number %% 100 != 0){
      hundred_text <- paste0(hundred_text, " and ")
    }
  }
  paste0(hundred_text, last_two)
}

only_letters <- function(string){
  string %>% 
    str_replace_all(" ", "") %>%
    str_replace_all("-", "")
}

up_to_999 <- sapply(1:999, function(x){
  nchar(only_letters(number_as_text(x)))
})

sum(up_to_999) + nchar("onethousand")
