library(jsonlite)
library(tidyverse)

states<-c("alabama","alaska","arizona","arkansas","california","colorado","connecticut","delaware","florida","georgia","hawaii","idaho","illinois","indiana","iowa","kansas","kentucky","louisiana","maine","montana","nebraska","nevada","new_hampshire","new_jersey","new_mexico","new_york","north_carolina","north_dakota","ohio","oklahoma","oregon","maryland","massachusetts","michigan","minnesota","mississippi","missouri","pennsylvania","rhode_island","south_carolina","south_dakota","tennessee","texas","utah","vermont","virginia","washington","west_virginia","wisconsin","wyoming")
states_dfs<-c()

# get times
state_ratings<-fromJSON(paste0("./approvalData/missouri.json"),flatten=TRUE)
size1<-length(state_ratings$trendline)
print(size1)
entries<-unlist(state_ratings$trendline)
size2<-length(entries)
times<-substr(names(entries[seq(1,size2,by=3)]),1,13)

ratings_df<-data.frame(unix_time=as.numeric(times)/1000) %>%
  mutate(date=as.Date(as.POSIXct(unix_time, origin="1970-01-01")))
tail(ratings_df)

for(state in states){
  state_ratings<-fromJSON(paste0("./approvalData/",state,".json"),flatten=TRUE)
  size1<-length(state_ratings$trendline)
  
  entries<-unlist(state_ratings$trendline)
  
  size2<-length(entries)
  
  approves<-as.vector(entries[seq(1,size2,by=3)])
  approves
  
  disapproves<-as.vector(entries[seq(2,size2,by=3)])
  disapproves
  
  neither<-as.vector(entries[seq(3,size2,by=3)])
  neither
  
  net_approval<-approves-disapproves
  
  state_ratings_df<-data.frame(net_approval)
  names(state_ratings_df)[1]<-paste0(state,"_net_approval")
  
  # append dfs together
  ratings_df<-c(ratings_df, state_ratings_df)
}
head(as.data.frame(ratings_df))
ratings_by_date<-as.data.frame(ratings_df)




# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
