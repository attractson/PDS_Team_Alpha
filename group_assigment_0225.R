rm(list=ls())

library(tidyverse)

#For Danny
EX<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")
head(EX)
#16 variables
EX1<- EX %>%
  select(starts_with("inst"))%>%
  mutate_all(na_if(x, x>4))5 %>%
  mutate_all()
  map_int()
##assign  8



  
  
  