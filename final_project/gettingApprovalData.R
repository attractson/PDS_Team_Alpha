library(jsonlite)
a<-fromJSON("C:/Users/ians-pc/Desktop/missouri_approval.json",flatten=TRUE)
a$trendline[1]
str(as.data.frame(a))

# install.packages("rjson")
# library(rjson)
# json_file <- "C:/Users/ians-pc/Desktop/missouri_approval.json"
# json_data <- fromJSON(file=json_file)
# json_data
