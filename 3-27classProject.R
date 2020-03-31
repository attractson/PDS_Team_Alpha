library(tidyverse)
electData<-read.csv("http://politicaldatascience.com/PDS/Datasets/presElect.csv")
Model1<-lm(vote~q2gdp, data=electData)
summary(Model1)

electData$vote[electData$year==2016]

Model2<-lm(vote~q2gdp+JuneApp, data=electData[electData$year!=2016,])
predict(Model2, newdata=electData[electData$year==2016,])

Model3<-lm(vote~q2gdp+JuneApp, data=electData)
summary(Model3)

Model4<-lm(vote~JuneApp+Inc, data=electData)
summary(Model4)

# SLIDE 27
Model5<-lm(vote~q2gdp+term, data=electData[electData$year!=2016,])
predict(Model5, newdata=electData[electData$year==2016,])
summary(Model5)



library(readr)
senateData<-read_csv("http://politicaldatascience.com/PDS/Datasets/SenateForecast/CandidateLevel.csv")

SimpleModelFull<-lm(VotePercentage~pvi*Republican+Incumbent, data=senateData)
summary(SimpleModelFull)$r.squared

ComplexModelFull<-lm(VotePercentage~pvi*Republican+weightexperience 
                     + GenericBallotSept*Republican + Incumbent, data=senateData)
summary(ComplexModelFull)$r.squared


# cross validation
library(rsample)
split_senateData<-initial_split(senateData, prop=.8)
senate_train<-training(split_senateData)
senate_test<-testing(split_senateData)

SimpleModelTrain<-lm(VotePercentage~pvi*Republican+Incumbent, data=senate_train)
SimpleModelPredictions<-predict(SimpleModelTrain, newdata=senate_test)
sqrt(mean((SimpleModelPredictions-senate_test$VotePercentage)^2))


ComplexModelTrain<-lm(VotePercentage~pvi*Republican+weightexperience 
                      + GenericBallotSept*Republican + Incumbent, data=senate_train)
ComplexModelPredictions<-predict(ComplexModelTrain, newdata=senate_test)

senate_test
ComplexModelPredictions
sqrt(mean((ComplexModelPredictions-senate_test$VotePercentage)^2))

### PROJECT PART
# senateData[senateData$cycle==2016,]
# senateData[senateData$Candidateidentifier=="2018MOMcCaskill",]

# DATA WE ARE TRYING TO PREDICT:
senate2018<-read_csv("CandidateLevel2018.csv")
senate2018<-senate2018 %>% rename(VotePercentage = Percentage.of.Vote.won.x) %>% rename(weightexperience = Weightedexperience)
senate2018

# TRAINING DATA:
senateData
senateModelTrain<-lm(VotePercentage~pvi + Democrat + weightexperience, data=senateData)
senateModelPredictions<-predict(senateModelTrain, newdata=senate2018[1,])

senate2018$predictions = senateModelPredictions


filter<-senate2018$Candidateidentifier %in% c('2018MOMcCaskill', '2018OHBrown', '2018WVManchin')
senate2018[filter,c("Candidateidentifier","predictions")]


