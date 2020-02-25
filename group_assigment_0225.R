rm(list=ls())

library(tidyverse)

#For Danny
EX<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")
head(EX)
select(EX, starts_with("inst"))
#16 variables
Ex %>%
  mutate_all(inst_court_2019= na_if(inst_court_2019, inst_court_2019>4)) %>%
  
  