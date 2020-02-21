library(tidyverse)
tweets<-read_csv("./Tweets.csv")
aTweet<-tweets[1,]$Text

mayors<-read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")

mayors %>% filter(LastName == "Krewson") %>% select(TwitterHandle)
#lydakrewson

tweets
all_tweets<-tweets %>% filter(ScreenName=="lydakrewson")

all_tweets$aaa<-for(i in 1:nrow(all_tweets)){
  str_c(unlist(all_tweets$Text), collapse=" ")
}

dim(all_tweets)

all_tweets

length(all_tweets)

total_number_words <- lengths(str_split(all_tweets, pattern=" "))
total_number_of_tweets <- lengths(all_tweets)

mean_words <- total_number_words / total_number_of_tweets


unique_words<-unique(unlist(str_split(all_tweets, pattern=" ")))
unique_words
total_unique_words <- length(unlist(unique_words))
total_unique_words

all_tweets
unique(all_tweets)

str_split(all_tweets, pattern=" ")
unique(c("the", "the"))


unlist(str_split(all_tweets, pattern=" "))


nrows(all_tweets)

str_detect(all_tweets, "polic")
all_tweets
str_split(all_tweets, pattern=" ")
