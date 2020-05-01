library(tidyverse)
library(dplyr)
covid_by_state<-read.csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv')
covid_by_state$date<-as.Date(covid_by_state$date)


covid_by_state<-covid_by_state%>%mutate(death_rate=deaths/cases)

covid_by_state = covid_by_state %>%
  group_by(state) %>%
  arrange(date) %>%
  mutate(Diff_date = date - lag(date),  
         Diff_growth = cases - lag(cases)#,
         #Rate_percent = (Diff_growth /as.integer(Diff_date)/cases * 100
         )
#still have bug
