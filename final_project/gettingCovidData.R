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
