turnout<-read.csv("http://politicaldatascience.com/PDS/Datasets/SimpleTurnout2008.csv")
dim(turnout)
turnout

Model1<-glm(turnout ~ inc + age, family="binomial", data=turnout)
summary(Model1)

Model1preds<-predict(Model1, type="response")
Model1preds

boxplot(Model1preds~turnout$inc, xlab="Income", ylab="Predicted Probabilities")
turnout$inc

# slide 23
precision<-46418/(18523+46418)
recall<-46418/(18523+3809)
accuracy<-(4283+46418)/(3809+18523+4283+46418)


library(rpart)
equation<-as.formula("turnout~eth+inc+age")
tree_mod1<-rpart(equation, data=turnout)
tree_mod1
plot(tree_mod1)

tree_mod2<-rpart(equation, data=turnout, control=rpart.control(cp=.0002))
plot(tree_mod2)
text(tree_mod1, use.n=TRUE, all = TRUE, cex=0.7)

tree_mod3<-rpart(equation, data=turnout, control=rpart.control(cp=.002))
plot(tree_mod2)
text(tree_mod1, use.n=TRUE, all = TRUE, cex=0.7)

treePreds1<-predict(tree_mod1); treePreds2<-predict(tree_mod2)
treePreds3<-predict(tree_mod3)


# TREE 1
collapsed<-(treePreds1>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & turnout$turnout==0)
falseNeg<-sum(collapsed==0 & turnout$turnout==1)
falsePos<-sum(collapsed==1 & turnout$turnout==0)
truePos<-sum(collapsed==1 & turnout$turnout==1)


precision<-truePos/(truePos+falsePos)
recall<-truePos/(truePos+falseNeg)
acc<-(truePos+trueNeg)/(trueNeg+falseNeg+falsePos+truePos)

precision
recall
acc

brier<-sqrt(sum((turnout$turnout-treePreds1)^2)/(trueNeg+falseNeg+falsePos+truePos))
brier

# TREE 2
collapsed<-(treePreds2>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & turnout$turnout==0)
falseNeg<-sum(collapsed==0 & turnout$turnout==1)
falsePos<-sum(collapsed==1 & turnout$turnout==0)
truePos<-sum(collapsed==1 & turnout$turnout==1)


precision<-truePos/(truePos+falsePos)
recall<-truePos/(truePos+falseNeg)
acc<-(truePos+trueNeg)/(trueNeg+falseNeg+falsePos+truePos)

precision
recall
acc

brier<-sqrt(sum((turnout$turnout-treePreds2)^2)/(trueNeg+falseNeg+falsePos+truePos))
brier

# TREE 3

collapsed<-(treePreds3>0.5)*1
collapsed # THIS IS THE PREDICTION

trueNeg<-sum(collapsed==0 & turnout$turnout==0)
falseNeg<-sum(collapsed==0 & turnout$turnout==1)
falsePos<-sum(collapsed==1 & turnout$turnout==0)
truePos<-sum(collapsed==1 & turnout$turnout==1)


precision<-truePos/(truePos+falsePos)
recall<-truePos/(truePos+falseNeg)
acc<-(truePos+trueNeg)/(trueNeg+falseNeg+falsePos+truePos)

precision
recall
acc

brier<-sqrt(sum((turnout$turnout-treePreds3)^2)/(trueNeg+falseNeg+falsePos+truePos))
brier

# FOREST
install.packages(randomForest)
library(randomForest)
turnout$turnout<-as.factor(turnout$turnout) # Leave as continuous for regression
mod1_forest<-randomForest(equation, data=turnout, 
                          ntree=201, mtry=2)
mod1_forest # This confusion matrix is "out of bag"