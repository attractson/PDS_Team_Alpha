
Model1preds<-predict(Model1, type="response")

binaryPred<-(Model1preds>0.5)*1
table(binaryPred, turnout$turnout)
