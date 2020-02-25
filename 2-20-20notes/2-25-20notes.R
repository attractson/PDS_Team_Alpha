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


##back to note

VSG1<-read_csv("~/Downloads/VOTER_Survey_Jan217_Release1-csv.csv")
VSG.fav<-VSG1 %>% 
  select(starts_with("fav"))
##o **overriding with NA
output<-as.data.frame(matrix(NA, nrow(VSG.fav), ncol(VSG.fav)))
for(i in seq_along(VSG.fav)){
  output[,i]<-(VSG.fav[,i]<=2)*1
}
for(i in seq_along(VSG.fav)){
  VSG.fav[,i]= na_if(VSG.fav[[i]],VSG.fav[[i]]>4)
  VSG.fav[,i]<-(VSG.fav[,i]<=2)*1
}
head(VSG.fav)

#map -> list
#map_lgl makes a logical vector 
#map_int makes an integer 
#map_dbl makes a double vector 
#map_chr makes a character
map(VSG.fav, mean, na.rm=TRUE)

map_dbl(VSG.fav, mean, na.rm=TRUE)





