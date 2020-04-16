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

Model1preds<-predict(Model1, newdata=testingData, type="response")
Model1preds

collapsed<-(Model1preds>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & testingData$incumbentWon==0)
falseNeg<-sum(collapsed==0 & testingData$incumbentWon==1)
falsePos<-sum(collapsed==1 & testingData$incumbentWon==0)
truePos<-sum(collapsed==1 & testingData$incumbentWon==1)

trueNeg
falseNeg
falsePos
truePos


#FOREST
install.packages(randomForest)
library(randomForest)

equation<-as.formula("incumbentWon ~ cycle+state+Republican*pvi+weightexperience")
mod1_forest<-randomForest(equation, data=trainingData, 
                          ntree=201, mtry=2)

forestpreds<-predict(mod1_forest, newdata=testingData, type="response")
collapsed<-(forestpreds>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & testingData$incumbentWon==0)
falseNeg<-sum(collapsed==0 & testingData$incumbentWon==1)
falsePos<-sum(collapsed==1 & testingData$incumbentWon==0)
truePos<-sum(collapsed==1 & testingData$incumbentWon==1)

trueNeg
falseNeg
falsePos
truePos

#KNN
library(class)
trainingData
testingData

trainingDataX<-trainingData[,c("cycle", "state", "weightexperience", "Republican", "pvi")]
senateX$inc<-senateX$inc+rnorm(length(senateX$inc), 0, .001)
testX<-testingData[,c("cycle", "state", "weightexperience", "Republican", "pvi")]
testX$inc<-senateX$inc+rnorm(length(senateX$inc), 0, .001)

mod1_knn<-knn(trainingData[,c("cycle", "Republican","weightexperience","pvi")], test=testingData[,c("cycle","Republican","weightexperience", "pvi")], cl=trainingData$incumbentWon, k=10)

trueNeg<-sum(mod1_knn==0 & testingData$incumbentWon==0)
falseNeg<-sum(mod1_knn==0 & testingData$incumbentWon==1)
falsePos<-sum(mod1_knn==1 & testingData$incumbentWon==0)
truePos<-sum(mod1_knn==1 & testingData$incumbentWon==1)

trueNeg
falseNeg
falsePos
truePos
