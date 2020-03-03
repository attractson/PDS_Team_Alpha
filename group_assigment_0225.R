rm(list=ls())

library(tidyverse)

#For Danny
##http://ippsr.msu.edu/sites/default/files/correlatesofstatepolicyprojectv2_1.csv
EX<-read_csv("~/Downloads/correlatesofstatepolicyprojectv2_1.csv")
head(EX)
#16 variables
EX1<- EX %>%
  select(starts_with("inst"))%>%
  mutate_all(na_if(x, x>4))5 %>%
  mutate_all()
  map_int()
##assign  8



  
  
  