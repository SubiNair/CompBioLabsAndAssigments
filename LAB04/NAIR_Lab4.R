#Surabhi Nair
#Lab04

# for loop printing hi ten times
for (i in seq(1,10)) {
  print("hi")
}

#Tim and his allowance
#Add the allowance to his current balance
#Then subtract 2* the gum cost from it
#This is now the initial balance for the next week
currBalance <- 10
allowance <- 5
gum <- 1.34

for (i in seq(1,8)) {
  newBalance <- allowance + currBalance
  finalBalance <- newBalance - (2 * gum)
  currBalance <- finalBalance
  print(finalBalance)
}


#Population Size
initSize <- 2000
shrinkage <- 0.05

#Calculate the change and then take the change away from the starting size
for (i in seq(1,7)) {
  changeSize <- initSize * shrinkage
  newSize <- initSize - changeSize
  print(newSize)
  initSize <- newSize
}


#Logistic growth equation
#our initial value is 2500
#The population should approach the carrying apacity K

initVal <- 2500
K <- 10000
r <- 0.8
totalSize <- 12
logGrowth <- rep(initVal, totalSize)

#since the for loop technically starts at n[2], we will move only to 11
for (i in 2:(totalSize)) {
  logGrowth[i] <- logGrowth[i-1] + (r * logGrowth[i-1] * (K - logGrowth[i-1])/K)
  print(logGrowth[i])
  cat("population size should approach: ", K, "\n")
}


#PART II
#Arrays using for loops
#A vector where every value is 3 times hte index
myVector <- rep(0, 18)
for (i in seq(1,18)) {
  myVector[i] <- i*3
}

print(myVector)


#1c -- make first value 1
#In this vector each value is 2 * the previous entry + 1
newVector <- rep(0, 18)
newVector[1] <- 1

for (i in seq(2,18)) {
  newVector[i] <- (2 * newVector[i-1]) + 1
}

print(newVector)

#Now for the first 20 fibonacci numbers
#Simply start the loop at the 3rd index after the first 2 are set to 1
fibonacci <- rep(0, 20)
fibonacci[1] <- 1
fibonacci[2] <- 1

for (i in seq(3,20)) {
  fibonacci[i] <- fibonacci[i-1] + fibonacci[i-2]
}

print(fibonacci)


#The logistic growth equation results were already stored in a vector
#So we can simply transfer it for readability and then plot it
abundance <- logGrowth

time <- seq(1,12)

plot(time, abundance)


#metadata files
#We will be writing the percent changes to a new file

setwd("/Users/subi/Desktop/CompBioLabsAndAssignments/LAB04")
data <- read.csv("CO2_data_cut_paste.csv")


percentFrame <- data

#Since the result will have 1 fewer row we are going to fill the top row with NA

percentFrame[1, 2:7] <- 'NA'

#to calculate percentage change
# d[i] - d[i-1] / d[i-1]  * 100
#across all columns

#First we go into a column
#Then through all of the rows of that column
#and then jump to next column and repeat
#j is rows, i is columns
for (i in seq(2,8)) {
  for (j in seq(2,263)) {
    percentFrame[j, i] <- ((data[j, i] - data[j-1, i]) / data[j-1, i]) * 100
  }
}

#We can write the data into a file 
write.csv(x = percentFrame, file = "YearlyPercentChangesInCO2.csv")


