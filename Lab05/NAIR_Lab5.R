#Surabhi Nair
#Lab 5

#Create x and assign a value greater than 5
x <- 9

#Now we can create a conditional to check if our value is greater than 5
if (x > 5) {
  print("The value of x is greater than 5")
} else {
  print("The value of x is less than or equal to 5")
}

#Set working directory to location of Lab05 and Vector1.csv
setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/Lab05")

#Storing the csv values in data
data <- read.csv("Vector1.csv")

#It is important to note that data is a data frame and all the values are stored under variable x
#So we need to go through x to actually access the values
#We do this with data$x
#We also need to keep in mind that we only have one column but many rows, so that is what we iterate through
#replace all of the negative values with NA
for (i in seq(1,length(data$x))) {
  if (data[i, 1] < 0) {
    data[i, 1] <- NA
  }
}
#We can store the indeces that have an NA value into a variable
#We can then change all the rows that have these indeces to 0
dataNAVals <- which(is.na(data))
data[dataNAVals, 1] <- 0

#Now we can pull out the indeces for values that are over 50 and under 100
#Then we can go through the original data frame and get the actual values
dataFtoH <- which(100 > data & data > 50)
data50_100 <- data[dataFtoH, 1]
print(data50_100)

#Now using the CO2 data
#Grab the gas column and filter out indeces that are greater than 0 into co2Gas
#Then use a separate variable to grab all the years that are matching the indeces of the co2Gas variable
co2data <- read.csv("CO2_data_cut_paste.csv")
co2Gas <- which(co2data$Gas > 0)
co2Year <- co2data$Year[co2Gas]

#Now we can just scrape the first value
co2FirstYear <- co2Year[1]
print(co2FirstYear)

#Filter out Total emissions greater than 200 and less that 300 (million)
co2Total <- which(co2data$Total > 200 & co2data$Total < 300)
co2TotalYears <- co2data$Year[co2Total]
print(co2TotalYears)

#PART II
#Implementing the "Lotka-Volterra" predator-prey model
totalGenerations <- 1000
initPrey <- 100     # initial prey abundance
initPred <- 10      # initial predator abundance
a <- 0.01       # attack rate
r <- 0.2        # growth rate of prey
m <- 0.05       # mortality rate of predators
k <- 0.1        # conversion constant of prey into predators

#Since we have totalGenerations, we can create a vector to reflect that amount of time
time <- seq(1, totalGenerations)

#Now we can do the same for our n and p vectors
n <- rep(0, totalGenerations) #prey abundance
p <- rep(0, totalGenerations) #predator abundance

#Adding in the initial values
n[1] <- initPrey
p[1] <- initPred

#This is the loop where we implement the calculations
for (t in seq(2,length(time))) {
  n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
  p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])
  
  #These are checks to ensure that there are no negative values
  #this also pevents erroneous values such as NaN and Inf
  if (n[t] < 0) {
    n[t] <- 0
  } 
  if (p[t] < 0) {
    p[t] <- 0
  } 
}
