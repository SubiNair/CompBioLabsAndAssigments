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
#PollenData$Pollen.Colour <- gsub("?",NA,PollenData$Pollen.Colour, fixed = TRUE)
#PollenData <- na.omit(PollenData)

#Assigning columns of Foraging data to variables
daysSinceExp <- ForagingData$Days.after.start.of.experiment
dailyBouts <- ForagingData$No..foraging.bouts.per.day
fTreat <- as.vector(ForagingData$Treatment)

fparam <- length(fTreat)

ForagingReg <- function(treatment) {
  treatmentLocations <- which(fTreat %in% treatment)
  treatBouts <- length(treatmentLocations)
  print(treatBouts)
  for(i in seq(0, treatBouts)) {
  
      foragingMatrix <- matrix(nrow = treatBouts, ncol = 2)
      for(x in seq(1, treatBouts)) {
        #Populate the matrix that we can later sort
        for(y in seq(1,2)) {
          
          #Will either populate with the day or the actual bout number
          #depending on the column
          if(y == 1) {
            foragingMatrix[x,y] <- daysSinceExp[treatmentLocations[x]]
          }
          if(y == 2) {
            foragingMatrix[x,y] <- dailyBouts[treatmentLocations[x]]
          }
        }
      }
  }
  
  
  #We want to sort by the days, the first column
  foragingMatrix <- foragingMatrix[order(foragingMatrix[,1]),]
  return(foragingMatrix)
}

AvgReg <- function(matrixVals) {
  eachday <- unique(matrixVals[,1])
  totaldays <- length(eachday)
  avgMatrix <- matrix(nrow = totaldays, ncol = 2)
  avgMatrix[,1] <- eachday
  t <- 1
  for(i in eachday) {
    vals <- matrixVals[matrixVals[,1] == i,]
    #print(vals)
    #print(length(vals))
    if(length(vals) > 2) {
      regvals <- mean(vals[,2])
    }else {
      regvals <- vals[2]
    }
   # print(i)
   # print(regvals)
    avgMatrix[t, 2] <- regvals
    t <- t + 1
  
  }
  
  return(avgMatrix)
}



#Now that we have the matrix of just what we want we can plot it
Aregression <- ForagingReg("A")
AregAvg <- AvgReg(Aregression)
plot(AregAvg[,1], AregAvg[,2], main = "Average A Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")


Bregression <- ForagingReg("B")
BregAvg <- AvgReg(Bregression)
plot(BregAvg[,1], BregAvg[,2], main = "Average B Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")

Cregression <- ForagingReg("C")
CregAvg <- AvgReg(Cregression)
plot(CregAvg[,1], CregAvg[,2], main = "Average C Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")

Dregression <- ForagingReg("D")
DregAvg <- AvgReg(Dregression)
plot(DregAvg[,1], DregAvg[,2], main = "D Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")





########## POLLEN SCORE POISSON CALCULATIONS #################

#Assigning the columns to variables
pDates <- as.vector(PollenData$Date)
pColor <- PollenData$Pollen.Colour
pScore <- PollenData$Pollen.Score
pTreat <- as.vector(PollenData$Treatment)

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

possibleScores <- c(0,1,2,3)

#We are creating these distributions by treatment
#First we will start with the A treatment
#Which was the control
#Indeces for all the As in the treatment vector
#Take those indeces to the scores and then average them
#Now you have your lambda
#Then we can use the dpois function or rpois (look into this)

#This collects the indeces for the control and then finds their respective pollen scores


###A
ATreatLocs <- which(pTreat %in% "A")
A_Scores <- pScore[ATreatLocs]

#Calculating the respective lambda
A_lambda <- mean(A_Scores)
A_dpoisvals <- rep(0, 4)

for (i in possibleScores) {
  A_dpoisvals[i+1] <- dpois(x = i, lambda = A_lambda)
}

print(A_dpoisvals)
plot(possibleScores, A_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5))
Aline <- lm(A_dpoisvals ~ poly(possibleScores, 2))
summary(Aline)

######B
BTreatLocs <- which(pTreat %in% "B")
B_Scores <- pScore[BTreatLocs]

#Calculating the respective lambda
B_lambda <- mean(B_Scores)
B_dpoisvals <- rep(0, 4)

for (i in possibleScores) {
  B_dpoisvals[i+1] <- dpois(x = i, lambda = B_lambda)
}

print(B_dpoisvals)
plot(possibleScores, B_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5))


####C
CTreatLocs <- which(pTreat %in% "C")
C_Scores <- pScore[CTreatLocs]

#Calculating the respective lambda
C_lambda <- mean(C_Scores)
C_dpoisvals <- rep(0, 4)

for (i in possibleScores) {
  C_dpoisvals[i+1] <- dpois(x = i, lambda = C_lambda)
}

print(C_dpoisvals)
plot(possibleScores, C_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5))

####D
DTreatLocs <- which(pTreat %in% "D")
D_Scores <- pScore[DTreatLocs]

#Calculating the respective lambda
D_lambda <- mean(D_Scores)
D_dpoisvals <- rep(0, 4)

for (i in possibleScores) {
  D_dpoisvals[i+1] <- dpois(x = i, lambda = D_lambda)
}

print(D_dpoisvals)
plot(possibleScores, D_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5))

