# combining data

# for consistency in data type
ratings_by_state$date <- as.character(ratings_by_state$date)
covid_by_state$date <- as.character(covid_by_state$date)

str(ratings_by_state) # ratings dataframe
str(covid_by_state) # cases and deaths dataframe

combined_data<-inner_join(ratings_by_state, covid_by_state, by=c("state", "date"))
combined_data


# FOR GRAPHING

# example for data from one state
combined_data[combined_data$state=="alabama",]
# list of all the states
states