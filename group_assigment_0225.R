rm(list=ls())

library(tidyverse)

#For Danny
EX<-read_csv("./correlatesofstatepolicyprojectv2_1.csv")
head(EX)
#16 variables
EX1<- EX %>%
  select(starts_with("inst"))%>%
  mutate_all(na_if(x, x>4))5 %>%
  mutate_all()
  map_int()
##assign  8
  
prop<-function(x){
  x/100
}
  
a<-EX %>% 
  select(contains("incshare")) %>%
  colMeans(na.rm=TRUE) %>%
  lapply(prop)
  

a
  
  
  
  #apply(2, function(x) na_if(x, x>4)) %>%

a[1:100,]


apply(a, 2, mean)
colMeans(a, na.rm = TRUE, dims = 1)  
  
  