#Easier to describe how change happens than 
#to explicitly describe the state of the complex system

#Does it matter if we use discrete or continuous time?
#It is hugely different when you have discrete bouts of reproduction or death
#Vs having a continuous tme model that levels off at carrying capacity

#We are doing numerical work -- applying algos to very closely approximate the true solution
#We aren't doing analysis which is straight up calculus

#Runge-Kutta methods are something to read about and are implemented often

#we cannot loop over time when there are infinite time points
#To do this in R
#We need diff equations
#A fully parameterized system
###like how much time and what not

#Lets flesh out an example
#It is often the case that a discrete time model has a similar look to a continuous time model

###########################################################################
#Now using ode() from deSolve
#func in ode -- this is the differential equation
#R is going to approximate the value of y
#Using the func and it will do so for the parameter case specified by parms
library("deSolve")

r <- 2.5
k <- 1000
n0 <- 10
endTime <- 25
timeIncrement <- 0.01

#objects required by the solver
times <- seq(from = 0, to = endTime, by = timeIncrement)
parms <- list(r,k)
names(parms) <- c("r","k")

#function required by the solver
myLogisticODE <- function(t, y, parms) {
  #to use ode this funciton must have at least three args and they must
  #be in the order shows, t, y, parms
  
  #Here is the ODE
  dydt <- y * parms$r * (( parms$k - y) / parms$k)
  
  #To use ODE the function must return a list
  return (list(dydt))
}

#Calling the solver is easy if the prev stuff is right
#visulaize it where the first col is the times and the second col is the abundance over time
solution <- ode(y = n0, times = times, func = myLogisticODE, parms = parms)
plot(solution[,1], solution[,2], type = "l", xlab = "time", ylab = "abundance")









