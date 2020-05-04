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




##############


#getting covid data
library(tidyverse)
covid_by_county<-read_csv("./us-counties-covid.csv")
covid_by_state<-covid_by_county %>% group_by(date, state) %>%
  summarise(cases=sum(cases), deaths=sum(deaths))

covid_by_state
# change date from char to Date
covid_by_state<-covid_by_state %>%
  ungroup(date) %>% ungroup(state) %>%
  mutate(date=as.Date(date, format="%m/%d/%y")) %>%
  mutate(state=str_replace(tolower(state), " ", "_"), Diff_date = date - lag(date),  
         Diff_growth = cases - lag(cases))
covid_by_state

########################


# combining data

# for consistency in data type
ratings_by_state$date <- as.character(ratings_by_state$date)
covid_by_state$date <- as.character(covid_by_state$date)

str(ratings_by_state) # ratings dataframe
str(covid_by_state) # cases and deaths dataframe

combined_data<-inner_join(ratings_by_state, covid_by_state, by=c("state", "date"))
combined_data <- mutate(combined_data, net_approval_rate=net_approval-lag(net_approval))
combined_data

# FOR GRAPHING

# example for data from one state
combined_data
write.csv(combined_data,"./combined_data.csv")
# list of all the states
states

ggplot(combined_data[combined_data$state=="washington",], mapping=aes(x=as.Date(date)))+
  geom_line(aes(y = log(cases, base=10), colour = "cases")) +
  geom_line(aes(y = net_approval*10, colour = "netapproval")) +
  labs(x="Date", y="Net Approval and Cases", title="netapproval and cases over time")


# Finiding correlation between cases and net approval by state
correlation_vals<-c()
for(state in states){
  state_data<-combined_data[combined_data$state==state,]
  correlation<-unlist(cor.test(state_data$diff_growth,state_data$net_approval_rate,method="pearson"))[[4]]
  correlation_vals<-c(correlation_vals, correlation)
}

correlations<-data.frame(state=states, corr=correlation_vals)

# aside from texas, nebraska and a few other states. The correlation between netapproval and cases is close to -1

#may_projections<-lm()
