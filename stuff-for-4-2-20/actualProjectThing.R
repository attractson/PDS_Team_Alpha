library(tidyverse)

senateData<-read_csv("http://politicaldatascience.com/PDS/Datasets/SenateForecast/CandidateLevel.csv")
senateData %>% filter(RaceID==20161702)
raceWinners<-senateData %>% group_by(RaceID) %>% top_n(1, VotePercentage)# group by the race they were in, then get the row with the max vote percentage
raceWinners<-transmute(raceWinners, incumbentWon = (Incumbent==1)*1)
raceWinners$incumbentWon

senateData<-left_join(senateData, raceWinners)

senateData<-senateData %>% filter(Incumbent==1)

trainingData<-senateData %>% filter(year!=2016)
testingData<-senateData %>% filter(year==2016)


#linear model
Model1<-glm(incumbentWon ~ cycle+state+Republican*pvi+weightexperience, family="binomial", data=trainingData)
summary(Model1)

Model1preds<-predict(Model1, type="response")
Model1preds

collapsed<-(Model1preds>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & trainingData$incumbentWon==0)
falseNeg<-sum(collapsed==0 & trainingData$incumbentWon==1)
falsePos<-sum(collapsed==1 & trainingData$incumbentWon==0)
truePos<-sum(collapsed==1 & trainingData$incumbentWon==1)

trueNeg
falseNeg
falsePos
truePos


#lFOREST
Model1<-glm(incumbentWon ~ cycle+state+Republican*pvi+weightexperience, family="binomial", data=trainingData)
summary(Model1)

Model1preds<-predict(Model1, type="response")
Model1preds

collapsed<-(Model1preds>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & trainingData$incumbentWon==0)
falseNeg<-sum(collapsed==0 & trainingData$incumbentWon==1)
falsePos<-sum(collapsed==1 & trainingData$incumbentWon==0)
truePos<-sum(collapsed==1 & trainingData$incumbentWon==1)

trueNeg
falseNeg
falsePos
truePos
