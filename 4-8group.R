palestinians<- read.csv("https://jmontgomery.github.io/ProblemSets/longo.csv")
palestinians$interaction <- palestinians$Sample2009*palestinians$ZA
palestinians

summary(lm(militancy~Sample2009 + ZA + interaction, data=palestinians))

