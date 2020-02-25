rm(list=ls())
library(tidyverse)

mayors<-read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")


# need to make sure tweets file is in folder
tweets<-read_csv("./Tweets.csv")
## Danny
tweets<-read_csv("~/Downloads/Tweets.csv")


str(tweets)
# aTweet<-tweets[1,]$Text # get one row and one column
# split<-str_split(aTweet, pattern = " ")
# str(split)
# str(unlist(split))
# tweets$Text


# use something like this to create a list of Trues and Falses to see if each tweet matches some regex expression
# looks for any string that contains any of the words: "police", "cop(s)", "law enforcement" with any amount of space between the two words, " PD " with possible punctuation between the letters
subject1<-str_detect(tweets$Text, regex("police | cops? | law\\s*enforcement | \\s+p\\.{0,1}d\\.{0,1}\\s+", ignore_case=TRUE))

# looks for any string that contains any of the words: "black live(s) or black life" with any spacing between the two words
subject2<-str_detect(tweets$Text, regex("black\\s*(?:life|lives?)", ignore_case=TRUE))

# str_detect(c('hi there', 'hithere', 'hi    there'), regex("hi\\s*there"))

filter = subject1 | subject2

# then add it to a new column in the original tibble
tweets$containsSubjects = filter

# here's how to view the tweets and whether the expression was matched
tweets %>% select(X1, Text, containsSubjects) %>% filter(containsSubjects == TRUE)


####################
# get mayor data set ready
mayors %>%
  count(TwitterHandle) %>%
  filter(n>1)
# the TwitterHandles "robertgarcialb" and "rodhiggins2017" have two people associated with them

mayors %>% filter(TwitterHandle == "robertgarcialb" | TwitterHandle == "rodhiggins2017") %>% select(X1, TwitterHandle, FirstName, LastName)
# entries 1008 and 1408 need to be dropped

mayors<-mayors %>% filter(X1!=1008 & X1!=1408)
# now all TwitterHandles and mayor names are unique
####################


# group the tweets by twitter handle
by_twitterHandle <- tweets %>% group_by(ScreenName)
by_twitterHandle <- by_twitterHandle %>% summarize(numberOfTweetsWithSubject = sum(containsSubjects)) # this gets number of tweets on the subjects we filtered for from a specific twitter handle

by_twitterHandle # this contains screen name and number of tweets with subject


# Want to add column to by_twitterHandle that contains the population of the mayor associated with the twitter handle
by_twitterHandle<-rename(by_twitterHandle, TwitterHandle=ScreenName) # get column name to match the one in the mayors tibble

# use inner join to get information about each twitter handle because if there is no information about the mayor with the twitter handle, then there is no point in keeping the twitter handle
by_twitterHandle <- by_twitterHandle %>% inner_join(select(mayors, TwitterHandle, FirstName, LastName, Population), by="TwitterHandle")

# get rid of na data
by_twitterHandle <- by_twitterHandle %>% filter(!is.na(Population))

# group things together if they have a population within the same 1000
popGroupSize = 10000
test <- by_twitterHandle %>% group_by(groupPop = floor(Population/popGroupSize))
test <- test %>% summarize(averageTweets = mean(numberOfTweetsWithSubject)) # find the mean number of tweets per group

# ggplot(data=test, mapping=aes(x=log(groupPop,base=10), y=averageTweets))+
#   geom_point()

ggplot(data=test, mapping=aes(x=groupPop,base=10, y=averageTweets))+
  geom_point()+
  geom_smooth(se=FALSE)

# ggplot(data=by_twitterHandle, mapping=aes(x=Population, base=10, y=numberOfTweetsWithSubject))+
#   geom_point()+
#   geom_smooth(se=FALSE)


  
