library(tidyverse)
library(readr)
library('rvest')
# url for this lab
url <- 'https://raw.githubusercontent.com/Diego-Ibarra/biol3782/main/week8/imdb_100titles_2016.html'

# url of actual live imdb website
# url <- 'http://www.imdb.com/search/title?count=100&release_date=2019,2019&title_type=feature'

webpage <- read_html(url)

#Using CSS selectors to scrape the rankings section
rank_data_html <- html_nodes(webpage,'.text-primary')
#Converting the ranking data to text
rank_data <- html_text(rank_data_html)

rank_data <- as.numeric(rank_data)

title_data_html <- html_nodes(webpage,'.lister-item-header a')

#Converting the title data to text
title_data <- html_text(title_data_html)




#Using CSS selectors to scrape the description section
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')

#Converting the description data to text
description_data <- html_text(description_data_html)

description_data %>% 
  head()

#Removing '\n'
description_data <- gsub("\n","",description_data)

head(description_data)

#Using CSS selectors to scrape the Movie runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')

#Converting the runtime data to text
runtime_data <- html_text(runtime_data_html)

head(runtime_data)

#Removing mins and converting it to numerical

runtime_data <- gsub(" min","",runtime_data)
runtime_data <- as.numeric(runtime_data)

head(runtime_data)

#Using CSS selectors to scrape the Movie genre section
genre_data_html <- html_nodes(webpage,'.genre')

#Converting the genre data to text
genre_data <- html_text(genre_data_html)

head(genre_data)





#Removing \n
genre_data <- gsub("\n","",genre_data)

#Removing excess spaces
genre_data <- gsub(" ","",genre_data)

head(genre_data)

#taking only the first genre of each movie
genre_data <- gsub(",.*","",genre_data)

#Convering each genre from text to factor
genre_data <- as.factor(genre_data)

head(genre_data)

#Using CSS selectors to scrape the IMDB rating section
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

#Converting the ratings data to text
rating_data <- html_text(rating_data_html)

str(rating_data)


#Converting ratings to numeric
rating_data <- as.numeric(rating_data)

head(rating_data)
#Using CSS selectors to scrape the votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')

#Converting the votes data to text
votes_data <- html_text(votes_data_html)

#Removing commas
votes_data <- gsub(",","",votes_data)

#Converting votes to numerical
votes_data <- as.numeric(votes_data)

head(votes_data)

#Using CSS selectors to scrape the directors section
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')

#Converting the directors data to text
directors_data <- html_text(directors_data_html)

#Converting directors data into factors
directors_data <- as.factor(directors_data)

head(directors_data)
#Using CSS selectors to scrape the actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

#Converting the gross actors data to text
actors_data <- html_text(actors_data_html)

#Converting actors data into factors
actors_data <- as.factor(actors_data)

head(actors_data)

#Using CSS selectors to scrape the metascore section
metascore_data_html <- html_nodes(webpage,'.metascore')

#Converting the runtime data to text
metascore_data <- html_text(metascore_data_html)

#Removing extra space in metascore
metascore_data <- gsub(" ","",metascore_data)

head(metascore_data)

#converting metascore to numerical
metascore_data <- as.numeric(metascore_data)

head(metascore_data)

#Using CSS selectors to scrape the gross revenue section
gross_data_html <- html_node(html_nodes(webpage, '.lister-item-content'), '.sort-num_votes-visible span:nth-child(5)')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

length(gross_data)

head(gross_data)

#Using CSS selectors to scrape the gross revenue section
gross_data_html <- html_node(html_nodes(webpage, '.lister-item-content'), '.sort-num_votes-visible span:nth-child(5)')

#Converting the gross revenue data to text
gross_data <- html_text(gross_data_html)

length(gross_data)

head(gross_data)

#Removing '$' and 'M' signs
gross_data <- gsub("M","",gross_data)

gross_data <- substring(gross_data,2,6)

#converting gross_data to numerical
gross_data <- as.numeric(gross_data)

gross_data  %>% 
  head()
#Combining all the lists to form a data frame

movies_df <- data.frame(Rank = rank_data, Title = title_data,
                        Description = description_data, Runtime = runtime_data,
                        Genre = genre_data, Rating = rating_data,
                         
                        Votes = votes_data,
                        Gross_Earning_in_Mil = gross_data,
                        Director = directors_data, Actor = actors_data)
yes <- data.frame(Rank = rank_data, Title = title_data, Description = description_data, Gross_Earning_in_Mil = gross_data,Metascore = metascore_data )
str(movies_df)

qplot(data = movies_df, Runtime, fill = Genre,bins = 30)+
  theme_classic()
# Plot of runtime vs rating
ggplot(movies_df,aes(x = Runtime,y = Rating))+
  geom_point(aes(size = Votes,col = Genre))+
  theme_classic()
# Plot of runtime vs earnings
ggplot(movies_df, aes(x = Runtime, y = Gross_Earning_in_Mil))+
  geom_point(aes(size = Rating, col = Genre))+
  theme_classic()