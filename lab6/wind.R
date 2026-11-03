library(tidyverse)
library(readr)
Weather_Data_2017 <- read_csv("Weather_Data_2017.csv")
maxGust = subset(Weather_Data_2017, `Hourly Maximum Gust`> 34)