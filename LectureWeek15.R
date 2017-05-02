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


