#Surabhi Nair
#Final Project

#Using the r package rio we can convert our xlsx files to csv files
#library(rio)
#convert("Pollen_score_colour.xlsx", "Pollen_score_colour.csv")
#convert("Foraging_duration.xlsx", "Foraging_duration.csv")
#This is why there are csv files that are able to be read

#IMPORTANT
#The files need to be read in the following order

PollenData <- read.csv(file.choose("Pollen_score_colour.csv"))
ForagingData <- read.csv(file.choose("Foraging_duration.csv"))



#Assigning columns of Foraging data to variables
daysSinceExp <- ForagingData$Days.after.start.of.experiment
dailyBouts <- ForagingData$No..foraging.bouts.per.day
fTreat <- as.vector(ForagingData$Treatment)
pDates <- as.vector(PollenData$Date)
fparam <- length(fTreat)

#by testing in the console we can see that the dates do follow an order
#For example 2011-9-23 is greater than 2011-9-20
#We can use this to our advantage to order things chronologically
#This will come in handy for the distribution

scoreDates <- unique(pDates)
orderedScoreDates <- sort(scoreDates, decreasing = FALSE)



#This is a function to create a matrix of the days since the experiment
#and the amount of bouts for those days 
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


#This function will then calculate the averages for each day
#We will base the regression off of this
AvgReg <- function(matrixVals) {
  
  #eachday carries the unique dates
  #We can then use the size of eachday to determine how many rows we need
  eachday <- unique(matrixVals[,1])
  totaldays <- length(eachday)
  avgMatrix <- matrix(nrow = totaldays, ncol = 2)
  avgMatrix[,1] <- eachday
  t <- 1
  
  
  #We use the counter to move through the rows of our final matrix
  for(i in eachday) {
    vals <- matrixVals[matrixVals[,1] == i,]
    #When using the above command, if there is only one match it will return as a vector and not a matrix so the else is to deal with this edge case
    if(length(vals) > 2) {
      regvals <- mean(vals[,2])
    }else {
      regvals <- vals[2]
    }
    avgMatrix[t, 2] <- regvals
    t <- t + 1
  
  }
  
  return(avgMatrix)
}

#Now that we have the matrix of just what we want we can plot it
#The plots that are commented out contain all of the data points
#They were useful for providing some insight into the dataset but I ended up using the average values to repeat the analysis
#They can however still be visualized if one would like to take a look


Aregression <- ForagingReg("A")
#plot(Aregression[,1], Aregression[,2], ylim = c(0,40), main = "A Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")

AregAvg <- AvgReg(Aregression)
plot(AregAvg[,1], AregAvg[,2], ylim = c(0,12), main = "Average A Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Average Daily Foraging Bouts")
abline(lm(AregAvg[,2]~AregAvg[,1]), col="red")

Bregression <- ForagingReg("B")
#plot(Bregression[,1], Bregression[,2], main = "Average B Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")

BregAvg <- AvgReg(Bregression)
plot(BregAvg[,1], BregAvg[,2], ylim = c(0,12), main = "Average B Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Average Daily Foraging Bouts")
abline(lm(BregAvg[,2]~BregAvg[,1]), col="blue")


Cregression <- ForagingReg("C")
#plot(Cregression[,1], Cregression[,2], ylim = c(0,40), main = "Average C Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")



CregAvg <- AvgReg(Cregression)
plot(CregAvg[,1], CregAvg[,2], ylim = c(0,12),main = "Average C Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Average Daily Foraging Bouts")
abline(lm(CregAvg[,2]~CregAvg[,1]), col="black")


Dregression <- ForagingReg("D")
#plot(Dregression[,1], Dregression[,2], ylim = c(0,40), main = "D Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Number of Foraging Bouts")


DregAvg <- AvgReg(Dregression)
plot(DregAvg[,1], DregAvg[,2], ylim = c(0,12), main = "Average D Treatment Foraging Bouts",xlab = "Days since start of experiment", ylab = "Average Daily Foraging Bouts")
abline(lm(DregAvg[,2]~DregAvg[,1]), col="green")

########## POLLEN SCORE POISSON CALCULATIONS #################


## IMPORTANT
#These need to be performed after the csv has been read BEFORE any rows are discarded for containing NA values later down the line for the flower type analysis
#This means that if the program has been run all the way through
#In order to get the correct poisson results, the csv files need to be read in again

#Assigning the columns to variables


pScore <- PollenData$Pollen.Score
pTreat <- as.vector(PollenData$Treatment)

#We can use these individual dates to find their locations in the original set of dates
#Then we can use that index to find a corresponding pollen score
#For example for 9-28, we can find all the indeces with 9-28,
#And then those indeces in the pollen score data set will contain the pollen score for that date for that treatment

possibleScores <- c(0,1,2,3)

#We are creating these distributions by treatment
#First we will start with the A treatment as an example
#Indeces for all the As in the treatment vector
#Take those indeces to the scores and then average them
#Now you have your lambda
#Then we can use the dpois function to calculate probability for a bee bringing back a certain amount of pollen


###A
#This collects the indeces for the control and then finds their respective pollen scores
ATreatLocs <- which(pTreat %in% "A")
A_Scores <- pScore[ATreatLocs]

#Calculating the respective lambda
A_lambda <- mean(A_Scores)
A_dpoisvals <- rep(0, 4)

for (i in possibleScores) {
  A_dpoisvals[i+1] <- dpois(x = i, lambda = A_lambda)
}

print(A_dpoisvals)
plot(possibleScores, A_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5), main = "Treatment A Poisson Distribution for Pollen Score")
lines(lowess(possibleScores,A_dpoisvals), col="red")


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
plot(possibleScores, B_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5), main = "Treatment B Poisson Distribution for Pollen Score")
lines(lowess(possibleScores,B_dpoisvals), col="blue")

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
plot(possibleScores, C_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5), main = "Treatment C Poisson Distribution for Pollen Score")
lines(lowess(possibleScores,C_dpoisvals), col="black")
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
plot(possibleScores, D_dpoisvals, xlab = "Pollen Score", ylab = "Probability", ylim = c(0,.5), main = "Treatment D Poisson Distribution for Pollen Score")
lines(lowess(possibleScores,D_dpoisvals), col="green")

########## POLLEN SCORE OVER TIME ###############


#We can create a generalized function to pull out any values based on treatment alone
PolScore <- function(treatment, xvec) {
  treatindeces <- which(pTreat %in% treatment)
  print(treatindeces)
  treatmentlength <- length(treatindeces)
  polscorer <- rep(0, treatmentlength)
  for(i in seq(1,treatmentlength)) {
    polscorer[i] <- xvec[treatindeces[i]]
  }
  
  print(polscorer)
  return(polscorer)
}


APolScore <- PolScore("A", pScore)
ADates <- PolScore("A", pDates)

BPolScore <- PolScore("B", pScore)
BDates <- PolScore("B", pDates)

CPolScore <- PolScore("C", pScore)
CDates <- PolScore("C", pDates)

DPolScore <- PolScore("D", pScore)
DDates <- PolScore("D", pDates)

#This is a function to create an aggregate of all the pollen scores
PollenCalculator <- function(treatScore, treatdates) {
  print(length(treatdates))
  newDates <- rep(0, length(treatdates))
  
  #we want the matrix to have a slot for all the dates
  scoreMatrix <- matrix(nrow = length(treatdates), ncol = 2)
  for(i in seq(1,length(treatdates))) {
    
    #Since the dates are ordered in a vector already
    #We can use the index to denote the days since the start of the records
    newDates[i] <- match(treatdates[i],orderedScoreDates)
    
  }
  for(i in seq(1, length(treatScore))) {
    scoreMatrix[i, 1] <- newDates[i]
    scoreMatrix[i, 2] <- treatScore[i]
  }
  
  finalscoreMatrix <- scoreMatrix[order(scoreMatrix[,1]),]
  return(finalscoreMatrix)
}

#And once again we can use our average function
#Once that has been calculated we can plot with regression lines

ATotalScore <- AvgReg(PollenCalculator(APolScore, ADates))
plot(ATotalScore[,1], ATotalScore[,2], xlab = "Days from start of Experiment", ylab = "Pollen Load Collected", main = "Treatment A Pollen Load Collection")
abline(lm(ATotalScore[,2]~ATotalScore[,1]), col="red")

BTotalScore <- AvgReg(PollenCalculator(BPolScore, BDates))
plot(BTotalScore[,1], BTotalScore[,2], xlab = "Days from start of Experiment", ylab = "Pollen Load Collected", main = "Treatment B Pollen Load Collection")
abline(lm(BTotalScore[,2]~BTotalScore[,1]), col="blue")

CTotalScore <- AvgReg(PollenCalculator(CPolScore, CDates))
plot(CTotalScore[,1], CTotalScore[,2], ylim = c(0,3),xlab = "Days from start of Experiment", ylab = "Pollen Load Collected", main = "Treatment C Pollen Load Collection")
abline(lm(CTotalScore[,2]~CTotalScore[,1]), col="black")

DTotalScore <- AvgReg(PollenCalculator(DPolScore, DDates))
plot(DTotalScore[,1], DTotalScore[,2], xlab = "Days from start of Experiment", ylab = "Pollen Load Collected", main = "Treatment D Pollen Load Collection")
abline(lm(DTotalScore[,2]~DTotalScore[,1]), col="green")

############ FLOWER PREFERENCE #############

#Fixing the Pollen Data csv file
#Some of the pollen colours are listed as "?" and so we can replace them with NA
#And then get rid of anything with an NA

#IMPORTANT NOTE
#Since we are discarding rows with NA here, the csv files
#Will need to be reread into the program before redoing any other distributions
#The NA discardation only positively impacts this analysis

PollenData$Pollen.Colour <- gsub("?",NA,PollenData$Pollen.Colour, fixed = TRUE)
PollenDataNew <- na.omit(PollenData)

pColor <- PollenDataNew$Pollen.Colour
eachPref <- unique(pColor)


#For each of the treatments let us look at the top 4 flower types
A_poltypes <- PolScore("A", pColor)
A_poltypes <- sort(table(A_poltypes),decreasing=TRUE)[1:4]
barplot(A_poltypes, xlab = "Flower Type",ylim = c(0, 60), ylab = "Total Collected", main = "Treatment A flower preferences", col = "dark blue")

B_poltypes <- PolScore("B", pColor)
B_poltypes <- sort(table(B_poltypes),decreasing=TRUE)[1:4]
barplot(B_poltypes, xlab = "Flower Type", ylim = c(0, 60),ylab = "Total Collected", main = "Treatment B flower preferences", col = "light blue")

C_poltypes <- PolScore("C", pColor)
C_poltypes <- sort(table(C_poltypes),decreasing=TRUE)[1:4]
barplot(C_poltypes, xlab = "Flower Type", ylim = c(0, 60),ylab = "Total Collected", main = "Treatment C flower preferences", col = "black")

D_poltypes <- PolScore("D", pColor)
D_poltypes <- sort(table(D_poltypes),decreasing=TRUE)[1:4]
barplot(D_poltypes, xlab = "Flower Type", ylim = c(0, 90), ylab = "Total Collected", main = "Treatment D flower preferences", col = "light green")

