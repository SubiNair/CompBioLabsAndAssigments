##Lotka Volterra predator-prey model
####Surabhi Nair

#####Background

The logistic growth function script contains an implementation of the Lotka-Volterra predator prey model:

	n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )

The variables in the logistic growth function include:

* K, which is the carrying capacity of a population
* r, the intrinsic growth rate of the population
* t, the time
* n[t], the abundance at a given time
* n[t-1], the abundance at the previous time

The time t can be interpreted as the number of generations in a population. The model requires an initial population size, which is then affected by rate, carrying capacity, and as time passes, the previous generation's abundance.

#####Implementation

The function has four arguments: the initial population size, the number of generations (time), the carrying capacity, and the rate at which the population is growing. 

The first few lines contain error messages that print if the user enters in values that are impossible. For example:

	if(iSize < 0) {
    print("ERROR: Initial Population MUST be 0 or greater!")
    }

This particular message is for entering a starting population of zero, in which case there is not a population to run an analysis on. 

Other warnings include:

1. carrying capacity of 0
2. A time, or generation equal to 0


Once the values entered are practical, we proceed.

Based on the number of generations the user has entered, the function then creates an empty vector of 0s the same size as the number of generations. 

The first abundance value is set as the initial population entered. 

	n[1] <- iSize
	
We then implement the equation through a for loop, which begins at the second abundance, and loops until there are as many iterations as number of generations.

The final portion of the function creates a plot of the data generated. 

#####Data File
As an example, I generated data using a starting size of 1000, 20 generations, a K of 48000, and a rate of .823.

The data was written into a vector which was then turned into a data frame. The data frame combines the vector returned by the function and a sequence of 1 to the number of gens, which in this case was 20.

The 2 columns were named "generations" and "abundance", and were written into a .csv file.

