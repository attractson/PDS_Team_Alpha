library(tidyverse)
library(dplyr)
covid_by_state<-read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv')

covid_by_state$date<-as.Date(covid_by_state$date) #change date format
covid_by_state<-covid_by_state%>%mutate(death_rate=deaths/cases* 100) #calculate total death rate out of the confirm death case

#Rate_percent covid case growth rate
covid_by_state = covid_by_state %>%
  group_by(state) %>%
  arrange(date) %>%
  mutate(Diff_growth_date = date - lag(date),  
         Diff_growth = cases - lag(cases),
         Growth_rate_percent = Diff_growth /as.integer(Diff_growth_date)/cases* 100)

#Rate_percent covid death growth rate
covid_by_state = covid_by_state %>%
  group_by(state) %>%
  arrange(date) %>%
  mutate(Diff_death_date = date - lag(date),  
         Diff_death = deaths - lag(deaths),
         Death_rate_percent = Diff_death /as.integer(Diff_death_date)/deaths*100)

state_population<-read.csv('https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-population.csv')
state_population<-filter(state_population, year==2020)

#A graph contain all death growth rate, case growth rate, cumulative case percent and cumulative death percent 
#would be nice. Also watch out for na when graphing in the dataset, there are a lot of NA in the begining because 
#in the early stage there wasn't any covid case or death in some state. 

#if you can find csv data of 2020 us population by state, please do. I am trying to do more analysis base of the 
#perecntage of people who are infected and died in a state




