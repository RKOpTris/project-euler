# https://projecteuler.net/problem=19

# You are given the following information, but you may prefer to do some research for yourself.
# 
# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

normal_year <- 365
leap_year <- normal_year + 1
day_numbers <- 1:7
day_seq <- rep(day_numbers, length.out = year_length)
last_day <- day_seq[length(day_seq)]
year <- 1900
year_dow <- list(length(1900:2000))
year_dom <- list(length(1900:2000))

while(year < 2001){
  if(year %% 100 == 0 && year %% 4 == 0){
    year_length <- normal_year
    dom <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
  } else if(year %% 4 == 0){
    year_length <- leap_year
    dom <- c(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
  } else {
    year_length <- normal_year
    dom <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
  }
  year_dom[[year - 1899]] <- do.call(c, sapply(dom, function(x){1:x}))
  year_dow[[year - 1899]] <- day_seq <- rep(day_numbers, length.out = year_length)
  last_day <- day_seq[length(day_seq)]
  split_days <- paste0(day_numbers, collapse = "") %>% str_split(as.character(last_day)) %>% unlist()
  day_numbers <- paste0(split_days[2], split_days[1], last_day) %>% atomise()
  
  year <- year + 1
}

year_dow <- year_dow[-1]
year_dom <- year_dom[-1]

sundays_on_1st <- lapply(1:length(year_dow), function(x){
  dow <- year_dow[[x]] == 7
  dom <- year_dom[[x]] == 1
  sum(dow & dom)
}
) %>% unlist
sum(sundays_on_1st)

### NOT very elegant or concise and could be improved!