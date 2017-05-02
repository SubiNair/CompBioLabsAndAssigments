setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Assignment11")

#The above is to set my working directory to where my files will be
#Using the r package rio we can convert our xlsx files to csv files

library(rio)
convert("Pollen_score_colour.xlsx", "Pollen_score_colour.csv")
convert("Foraging_duration.xlsx", "Foraging_duration.csv")

#This way all of the empty cells are turned into NAs as well
#Now we can actually read them in and remove all of the NA values

PollenData <- read.csv("Pollen_score_colour.csv")
ForagingData <- read.csv("Foraging_duration.csv")

#Fixing the Pollen Data csv file
#Some of the pollen colours are listed as "?" and so we can replace them with NA
#And then get rid of anything with an NA
PollenData$Pollen.Colour <- gsub("?",NA,PollenData$Pollen.Colour, fixed = TRUE)
PollenData <- na.omit(PollenData)

#Assigning the columns to variables
pDates <- as.vector(PollenData$Date)
pColor <- PollenData$Pollen.Colour
pScore <- PollenData$Pollen.Score

#by testing in the console we can see that the dates do follow an order
#For example 2011-9-23 is greater than 2011-9-20
#We can use this to our advantage to order things chronologically
#This will come in handy for the distribution
scoreDates <- unique(pDates)
orderedScoreDates <- sort(scoreDates, decreasing = FALSE)

#We can use these individual dates to find their locations in the original set of dates
#Then we can use that index to find a corresponding pollen score
#For example for 9-28, we can find all the indeces with 9-28,
#And then those indeces in the pollen score data set will contain the pollen score for that date for that treatment

#We are creating these distributions by treatement





