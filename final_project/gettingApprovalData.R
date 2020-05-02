library(jsonlite)

state_ratings<-fromJSON("C:/Users/ians-pc/Desktop/missouri_approval.json",flatten=TRUE)
size1<-length(a$trendline)
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

ratings_df<-data.frame(time=times,approves,disapproves,neither)
ratings_df




  typeof(a$trendline[1])
(unlist(a$trendline[1])[1])
str(as.data.frame(a))

# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
