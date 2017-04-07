#Lab09
#Surabhi Nair

#Set up directory and files
setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Lab09")

CameraTrapData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv")
Hk6 <- read.csv("Holekampetal_data_Fig6.csv")
Hk7 <- read.csv("Holekampetal_data_Fig7.csv")
Hk8 <- read.csv("Holekampetal_data_Fig8.csv")

#name the columns
datetime <- (CameraTrapData$DateTime) 
placement <- as.vector(CameraTrapData$Placement)
station <- as.vector(CameraTrapData$Station)
season <- as.vector(CameraTrapData$Season)

#convert the factor to a vector
time_loc <- as.vector(datetime)

#Our function uses POSIX values to convert to a proper timestamp and then into a numeric value
calcTimeDiff <- function(time1, time2) {
  newtime1 <- as.numeric(as.POSIXct(time1, format="%d/%m/%Y %H:%M"))
  newtime2 <- as.numeric(as.POSIXct(time2, format="%d/%m/%Y %H:%M"))
  
  #Difference
  finaltime <- newtime2 - newtime1
  
  #Convert from seconds to days
  final_dist <- (finaltime / 86400)
  
  #return the absolute value of the time difference
  return(abs(final_dist))
}

print(calcTimeDiff(time_loc[1], time_loc[4]))

#Remember that this function returns the time difference in DAYS
#Which is why it is a decimal value

#FUNCTION 2

#IMPORTANT
#the "data" field should be the name of the csv file, in quotes
#For example "myfile.csv"
#with the exception of values that are numbers
#all other arguments need to be passed in with quotes around them
ConsecTrappings <- function(mydata = "abc", pl, se, st) {
  TrapData <- read.csv(file = mydata)

  #Convert each column to vectors and then put into variables
  place <- as.vector(TrapData$Placement)
  stat <- as.vector(TrapData$Station)
  seas <- as.vector(TrapData$Season)
  times <- as.vector(TrapData$DateTime)
  
  
  #Now we want the index locations from each vector of the actual argument
  #For instance, if we want Random placement
  #allplace will contain all of the locations of "Random" within the entire placement vector
  allplace <- which(place == pl)
  allstat <- which(stat == st)
  allseas <- which(seas == se)
  
  #We can then find where all three intersect
  #Now we have an index list that we can call our time calculation function on
  targetindeces <- intersect(intersect(allplace, allseas), allstat)

  #If we have n values to calculate the difference between, we will get n-1 differences
  #So intervals will contain n-1 values
  #limitation is the count of how many indeces there actually are
  #alltimes will be filled with the needed times
  limitation <- length(targetindeces)
  alltimes <- rep(0, limitation)
  intervals <- rep(0, limitation - 1)
  
  #Fill alltimes with the necessary times
  for(x in seq(1,limitation)) {
    index <- targetindeces[x]
    alltimes[x] <- times[index]
  }
  
  #We loop through alltimes
  #As we go we use calcTimeDiff and store the result
  for (i in seq(2,limitation)) {
    val <- calcTimeDiff(alltimes[i-1], alltimes[i])
    intervals[i-1] <- val
  }

  #return the final set of intervals
  return(intervals)
  
}


#Tests to make sure it worked
#print(ConsecTrappings("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", "Random", "D", 11))
#print(calcTimeDiff(time_loc[1], time_loc[4]))




