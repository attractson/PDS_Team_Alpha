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

