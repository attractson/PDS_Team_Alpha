rm(list=ls())
library(jsonlite)
library(tidyverse)

states<-c("alabama","alaska","arizona","arkansas","california","colorado","connecticut","delaware","florida","georgia","hawaii","idaho","illinois","indiana","iowa","kansas","kentucky","louisiana","maine","montana","nebraska","nevada","new_hampshire","new_jersey","new_mexico","new_york","north_carolina","north_dakota","ohio","oklahoma","oregon","maryland","massachusetts","michigan","minnesota","mississippi","missouri","pennsylvania","rhode_island","south_carolina","south_dakota","tennessee","texas","utah","vermont","virginia","washington","west_virginia","wisconsin","wyoming")

for(state in states){
  state_ratings<-fromJSON(paste0("./approvalData/",state,".json"),flatten=TRUE)
  size1<-length(state_ratings$trendline)
  
  entries<-unlist(state_ratings$trendline)
  
  size2<-length(entries)
  
  unix_times<-substr(names(entries[seq(1,size2,by=3)]),1,13)
  unix_times<-as.numeric(unix_times)/1000
  as.Date(as.POSIXct(unix_times, origin="1970-01-01"))
  dates<-as.Date(as.POSIXct(unix_times, origin="1970-01-01"))
  dates
  
  approves<-as.vector(entries[seq(1,size2,by=3)])
  approves
  
  disapproves<-as.vector(entries[seq(2,size2,by=3)])
  disapproves
  
  neither<-as.vector(entries[seq(3,size2,by=3)])
  neither
  
  net_approval<-approves-disapproves
  
  state_ratings_df<-data.frame(net_approval)
  names(state_ratings_df)[1]<-paste0(state,"_net_approval")
  
  # append new data to end of running df
  if(exists("ratings_df")){
    # df created already
    new_date<-c(ratings_df$date, dates)
    new_state<-c(ratings_df$state, c(rep(state, length(dates))))
    new_net_approval<-c(ratings_df$net_approval, net_approval)
  }
  else{
    # df not created yet
    new_date<-dates
    new_state<-rep(state, length(dates))
    new_net_approval<-net_approval
  }
  
  ratings_df<-data.frame(date=new_date, state=new_state, net_approval=new_net_approval, stringsAsFactors = FALSE)
}
head(ratings_df)

typeof(rep(state, length(dates)))

str(ratings_df)
ratings_by_state<-ratings_df


# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
