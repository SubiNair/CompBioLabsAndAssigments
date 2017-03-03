#Lab 7 -- Surabhi Nair

#PROBLEM 1
#Fibonacci sequence function
fibonacci <- function(n, starter = 1) {
  #Warning in case of a negative value or 0 being entered
  if(n <= 0) {
    print("ERROR: Negative value or zero entered! Please enter a positive value to commence!")
  }
  
  #Regardless of starting position, the next number is 1
  #We can create a vector of 0s the size of n
  fibSeq <- rep(0, n)
  nextnum <- 1
  
  #first the starter should be entered at the first position
  fibSeq[1] <- starter
  
  #If they only specified an n of 1 then we are done and we can return
  if(n == 1){
    return(fibSeq)
  }
  
  #Now the next number (always 1) should be entered into the vector
  fibSeq[2] <- nextnum
  
  #If they only want 2 values, then we are done
  if(n == 2) {
    return(fibSeq)
  }
  
  #For any other value
  #We have the first two values in the vector so we commence from position 3
  for (i in seq(3,n)) {
    
    #newval is one position ahead
    #This stores the sum
    newval <- nextnum + starter
    fibSeq[i] <- newval
    
    #Reset the starter to one position ahead 
    #Reset the nextnum to the new value you found, which is the same as shifting one ahead
    starter <- nextnum
    nextnum <- newval
  }
  return(fibSeq)
}

#PROBLEM 2
#Logistic growth model
logGrowth <- function(iSize = 100, numberOfGens = 20, K = 500, r = 1.5) {
  
  #Warning for negative arguments where not possible
  if(iSize < 0) {
    print("ERROR: Initial Population MUST be 0 or greater!")
  }
  if(numberOfGens < 0) {
    print("ERROR: Number of Generations MUST be 0 or greater!")
  }
  if(K < 0) {
    print("ERROR: Carrying Capacity MUST be 0 or greater!")
  }
  
  #First lets create a vector n that will hold our abundance values
  #The first value will be the initial size of the population
  n <- rep(0, numberOfGens)
  n[1] <- iSize
  
  #Now we can loop through and calculate each value
  for(t in seq(2,numberOfGens)) {
    n[t] <- n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
  }
  
  #We can make a y axis with a sequence from 1 to the number of Gens
  #we print a plot and return the final abundances
  timeGen <- seq(1,numberOfGens)
  finalPlot <- plot(timeGen, n, xlab = "Generations", ylab = "Abundances")
  return(n)
}


#PROBLEM 3
setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Lab07")
adjacencyMatrix <- read.csv(file.choose(), header=T)

matrixToPairwise <- function(inputmatrix) {
  
  columns <- ncol(inputmatrix)
  rows <- nrow(inputmatrix)
  
  #Make sure it is square
  if(rows != columns) {
    print("Matrix not square, try again!")
  }
  
  #We are trying to determine how many actual rows we need 
  #To preallocate a new pairwise matrix
  #So we find the amount of actual intereactions within the input
  newrows <- length(which(inputmatrix == 1))
  
  #We then use that to determine how many rows we need
  pairwiseMatrix <- matrix(0,nrow = newrows, ncol = 3)
  
  #This is going to be used to move down the rows of the new matrix
  countrow <- 1
  
  #Going through our input matrix and extracting anything with an interaction
  for(i in seq(1,rows)) {
    for(j in seq(1,columns)) {
      if(inputmatrix[i,j] == 1) {
        #We can replace the entire row of the pairwise matrix
        #With the row, column, and interaction in the input matrix
        pairwiseMatrix[countrow, ] <- c(i,j,inputmatrix[i,j])
        countrow <- countrow + 1
      }
    }
  }
  #return the pairwise matrix
  return(pairwiseMatrix)
  
}










