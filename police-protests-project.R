library(tidyverse)


# need to make sure tweets file is in folder
tweets<-read_csv("./Tweets.csv")

str(tweets)
aTweet<-tweets[1,]$Text # get one row and one column
split<-str_split(aTweet, pattern = " ")
str(split)
str(unlist(split))


tweets$Text
# use something like this to create a list of Trues and Falses to see if each tweet matches some regex expression
str_detect(tweets$Text, regex("a b c"))
