library(tidyverse)
library(readr)

mlb_pitching <- na.omit(read.csv("mlb2017_pitching.txt"))

mlb_pitching  %>% 
  head()
mlb_pitching <- mlb_pitching %>% 
  mutate(Name_clean = str_extract(Name,"[A-Z][a-z]+ [A-Z][a-z]+"))

mlb_pitching  %>% 
  select(Name,Name_clean) %>% 
  head()