library(jsonlite)
library(tidyverse)

state_ratings<-fromJSON("./missouri_approval.json",flatten=TRUE)
size1<-length(state_ratings$trendline)
size1

entries<-unlist(state_ratings$trendline)

size2<-length(entries)

times<-substr(names(entries[seq(1,size2,by=3)]),1,13)
times

approves<-as.vector(entries[seq(1,size2,by=3)])
approves

disapproves<-as.vector(entries[seq(2,size2,by=3)])
disapproves

neither<-as.vector(entries[seq(3,size2,by=3)])
neither


ratings_df<-data.frame(unix_time=as.numeric(times)/1000,approves,disapproves,neither)

ratings_df<-ratings_df %>% mutate(date=as.Date(as.POSIXct(unix_time, origin="1970-01-01"))) %>%
  mutate(net_approval = approves-disapproves)
tail(ratings_df)

# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
