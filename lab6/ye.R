library(tidyverse)
library(readr)
library('rvest')
# url for this lab
url <- 'https://raw.githubusercontent.com/Diego-Ibarra/biol3782/main/week8/imdb_100titles_2016.html'

webpage <- read_html(url)

#Using CSS selectors to scrape the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')
#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

rank_data <- as.numeric(rank_data)

title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)



temp = subset(movies_df, movies_df$Runtime>=100)
temp = subset(temp, temp$Runtime<=120)
view(temp)

ggplot(movies_df, aes(x = Rank, y = Gross_Earning_in_Mil))+
  geom_point(aes(size = Rating, col = Genre))+
  theme_classic()