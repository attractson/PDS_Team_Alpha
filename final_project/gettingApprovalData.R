library(jsonlite)

state_approval<-c()
state_
state_ratings<-fromJSON("C:/Users/ians-pc/Desktop/missouri_approval.json",flatten=TRUE)
size1<-length(a$trendline)
size1


entries<-unlist(a$trendline[c(1:size1)])
entries
size2<-length(entries)

approves<-as.vector(entries[seq(1,size2,by=3)])
approves[size1]

disapproves<-as.vector(entries[seq(2,size2,by=3)])
disapproves[size1]

neither<-as.vector(entries[seq(3,size2,by=3)])
neither[size1]




typeof(a$trendline[1])
(unlist(a$trendline[1])[1])
str(as.data.frame(a))

# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
