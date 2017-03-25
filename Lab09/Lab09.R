#Lab09

#Set up directory and files
setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Lab09")

CameraTrapData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv")
Hk6 <- read.csv("Holekampetal_data_Fig6.csv")
Hk7 <- read.csv("Holekampetal_data_Fig7.csv")
Hk8 <- read.csv("Holekampetal_data_Fig8.csv")

#name the column
datetime <- (CameraTrapData$DateTime) 
placement <- as.vector(CameraTrapData$Placement)
station <- as.vector(CameraTrapData$Station)
season <- as.vector(CameraTrapData$Season)



#convert the factor to a vector
test <- as.vector(datetime)

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

