#Two species, two dynamic variables
#Moose and snowshoe hare as competitors, browsers, diets overlap but aren't identical

#Now lets consider one species
#if one becomes too abundant then food source depleted

#Now we have a new formula to account for two species
#Alpha can be measured observationally -- how do you do alone
#and how do you do in the presence of another species (competitor)

#How do we set up a 2D ODE model? the Lotka Volterra competition model?
#Lets put in the params
#10% growth rate max
#symmetry in the sense of rates and carrying capacities
#a12 is the effect of organism 1 on organism 2 aka the equation for n2
library("deSolve")

r1 <- 0.1
r2 <- r1
k1 <- 1000
k2 <- k1
a12 <- 0.8
a21 <- 0.7
n1init <- 10
n2init <- 85
times <- seq(0, 400, 0.01)

#Now lets write our function
#parms would be a bigger list
#also y is going to have 2 things instead of one since you have n1 and n2
#y needs to be a vector of length 2


#We ned to reference the elements of y as a result
#how do we define our y value
competitionODE <- function(t, y, parms) {
  #to use ode this funciton must have at least three args and they must
  #be in the order shows, t, y, parms
  
  #Here is the ODE
  dn1dt <- y[1] * parms$r1 * (( parms$k1 - y[1] - parms$a21*y[2]) / parms$k1)
  dn2dt <- y[2] * parms$r2 * (( parms$k2 - y[2] - parms$a12*y[1]) / parms$k2)
  #To use ODE the function must return a list
  #IT HAS TO BE A LIST
  #but first bind it together as a vector, b/c it can only be a list of 1 object
  return(list(c(dn1dt, dn2dt)))
}

parms <- list(r1,k1,a21,r2,k2,a12)
names(parms) <- c("r1","k1","a21","r2","k2","a12")

#Our y in this situation would be the initial vals
solution <- ode(y = c(n1init, n2init), times = times, func = competitionODE, parms = parms)
plot(solution[,1], solution[,2], type = "l", xlab = "time", ylab = "abundance", ylim = c(0,1000), col = "red")
lines(solution[,1], solution[,3], col = "blue")
