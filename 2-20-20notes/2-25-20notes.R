rm(list=ls())

library(tidyverse)
VSG<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")
VSG.two <- select(VSG, fav_sanders_2019, fav_warren_2019)
VSG.three<-mutate(VSG.two, fav_sanders_binary = (fav_sanders_2019<=2))
VSG.four<-mutate(VSG.three, fav_sanders_binary= na_if(fav_sanders_2019, fav_sanders_2019>4))

rm(list=ls())
library(tidyverse)
VSG<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")

VSG <- select(VSG, fav_sanders_2019, fav_warren_2019)
VSG<-mutate(VSG, fav_sanders_binary = (fav_sanders_2019<=2)*1)
VSG<-mutate(VSG, fav_sanders_binary= na_if(fav_sanders_2019, fav_sanders_2019>4))

VSG<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")
VSG %>% 
  select( fav_sanders_2019, fav_warren_2019) %>%
  mutate(fav_sanders_binary= na_if(fav_sanders_2019, fav_sanders_2019>4)) %>%
  mutate(fav_sanders_binary = (fav_sanders_2019<=2)*1)

# 1 => to make boolean => numeric

library(magrittr)
VSG %>% 
  select( fav_sanders_2019, fav_warren_2019) %>%
  mutate(fav_sanders_binary= na_if(fav_sanders_2019, fav_sanders_2019>4)) %>%
  mutate(fav_sanders_binary = (fav_sanders_2019<=2)*1) %T>%
  plot()
VSG<- VSG %>% 
  select(fav_sanders_2019, fav_warren_2019) %>%
  mutate(fav_sanders_binary= na_if(fav_sanders_2019, fav_sanders_2019>4)) %>%
  mutate(fav_sanders_binary = (fav_sanders_2019<=2)*1) %>%
  mutate(fav_warrem_binary= na_if(fav_warren_2019, fav_warren_2019>4)) %>%
  mutate(fav_warren_binary = (fav_warren_2019<=2)*1)
VSG<- VSG %$% 
  plot(table(fav_sanders_binary, fav_warren_binary))


##excercise
VSGex<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")

VSGex<- VSGex %>% 
  select(fav_sanders_2019, fav_biden_2019) %>%
  mutate(fav_sanders_binary= na_if(fav_sanders_2019, fav_biden_2019>4)) %>%
  mutate(fav_sanders_binary = (fav_sanders_2019<=2)*1) %>%
  mutate(fav_biden_binary= na_if(fav_biden_2019, fav_biden_2019>4)) %>%
  mutate(fav_biden_binary = (fav_biden_2019<=2)*1)
VSGex<- VSGex %$% 
  plot(table(fav_sanders_binary, fav_biden_binary))




