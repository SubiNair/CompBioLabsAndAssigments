setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Assignment11")

#The above is to set my working directory to where my files will be
#Using the r package rio we can convert our xlsx files to csv files

library(rio)
convert("Pollen_score_colour.xlsx", "Pollen_score_colour.csv")
convert("Foraging_duration.xlsx", "Foraging_duration.csv")

#This way all of the empty cells are turned into NAs as well
#Now we can actually read them in and remove all of the NA values
#Some of the pollen colours are listed as "?" and so we can replace them with NA
#And then get rid of anything with an NA

PollenData <- read.csv("Pollen_score_colour.csv")
ForagingData <- read.csv("Foraging_duration.csv")

#Fixing the Pollen Data csv file
PollenData$Pollen.Colour <- gsub("?",NA,PollenData$Pollen.Colour, fixed = TRUE)
PollenData <- na.omit(PollenData)
pColor <- PollenData$Pollen.Colour
pScore <- PollenData$Pollen.Score




