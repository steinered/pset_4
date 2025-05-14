# for all indicators


# results = 50

# # for all indicators tables 1-4
# df %>% 
#   filter(!(OriginTable == 5)) %>% 
#   filter(ChiSq > 3.841) %>% 
#   nrow()

# results = 32

# for major indicators only
# df %>% 
#   # only indicators with "I" in indicators name
#   filter(grepl("I-", Indicators)) %>% 
#   filter(ChiSq > 3.841) %>% 
#   nrow()

# results = 38

# for major indicators only
# df %>% 
#   filter(!(OriginTable == 5)) %>%
#   # only indicators with "I" in indicators name
#   filter(grepl("I-", Indicators)) %>% 
#   filter(ChiSq > 3.841) %>% 
#   nrow()

# results = 21

# For a 2x2 table (Chi-Squared test), there is only 1 degree of freedom.
# The corresponding critical Chi-S value for p \< 0.05 is thus 3.841.
# "Significant predictors" are thus those with Chi-Squared results greater
# than 3.841.
# 
# If we look at all indicators, including sub-indicators (those without an
# "I-" preceding their name), there are 50 significant predictors across
# tables 1-5; 32 of these indicators are from one of the first 4 tables.
# 
# If we limit our investigation to only major indicators (those with "I-"
# preceding their name), there are 38 significant predictors; 21 of these
# significant predictors are from tables 1-4.