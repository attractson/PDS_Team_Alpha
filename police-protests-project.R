library(tidyverse)


# need to make sure tweets file is in folder
tweets<-read_csv("./Tweets.csv")

# str(tweets)
# aTweet<-tweets[1,]$Text # get one row and one column
# split<-str_split(aTweet, pattern = " ")
# str(split)
# str(unlist(split))
# tweets$Text


# use something like this to create a list of Trues and Falses to see if each tweet matches some regex expression
subject1<-str_detect(tweets$Text, regex("#blacklivesmatter", ignore_case=TRUE))
subject2<-str_detect(tweets$Text, regex("#hello", ignore_case=TRUE))
sum(subject1)
sum(subject2)
filter = subject1 | subject2


# then add it to a new column in the original tibble
tweets$containsSubjects = filter

# here's how to view the tweets and whether the expression was matched
tweets %>% select(Text, containsSubjects) %>% filter(containsSubjects == TRUE)
