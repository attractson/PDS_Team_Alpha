library(tidyverse)
VSG<-read_csv("./VOTER_Survey_Jan217_Release1-csv.csv")
with(VSG, table(fav_biden_2019))

VSG<-VSG %>% 
  mutate(fav_biden_2019=na_if(fav_biden_2019, 8)) %>%
  mutate(fav_biden_2019=na_if(fav_biden_2019, 98))
with(VSG, table(fav_biden_2019))

mean(VSG$fav_biden_2019, na.rm=TRUE)


set.seed(201)
sample_100= VSG %>%
  sample_n(size=100)

mean(sample_100$fav_biden_2019, na.rm=TRUE)

sd<-sd(VSG$fav_biden_2019, na.rm=T)
s<-sd/sqrt(400)

sd

mean_list<-c()

for(i in (1:500)){
  sample_400= VSG %>%
    sample_n(size=400)
  
  mean<-mean(sample_400$fav_biden_2019, na.rm=TRUE)
  
  mean_list[i]<-mean
}
mean(mean_list)
sd(mean_list)

##############

sample_300= VSG %>% sample_n(size=300)
sample.mean<-mean(sample_300$fav_biden_2019, na.rm=T)
sample.sd<-sd(sample_300$fav_biden_2019, na.rm=T)

z.score = qnorm((1-.05/2))

z

sample.mean - z.score*sample.sd/sqrt(300)
sample.mean + z.score*sample.sd/sqrt(300)
###############


bootstrap.means<-c()
sds<-c()
for(i in 1:1000){
  bootstrap_sample<-sample_300 %>% sample_n(size=300, replace=T)
  
  bootstrap.means[i]<-mean(bootstrap_sample$fav_biden_2019, na.rm=T)
  sds[i]<-sd(bootstrap_sample$fav_biden_2019, na.rm=T)
}

bootstrap.sd<-sd(bootstrap.means)
bootstrap.mean<-mean(bootstrap.means)
bootstrap.mean - z.score*bootstrap.sd
bootstrap.mean + z.score*bootstrap.sd
