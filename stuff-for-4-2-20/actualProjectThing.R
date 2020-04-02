library(tidyverse)

senateData<-read_csv("http://politicaldatascience.com/PDS/Datasets/SenateForecast/CandidateLevel.csv")
raceWinners<-senateData %>% group_by(RaceID) %>% top_n(1, VotePercentage)# group by the race they were in, then get the row with the max vote percentage

raceWinners %>% filter(RaceID==20161702)

#senateData$RaceID
senateData %>% filter(RaceID==20161702)
senateData$Gene