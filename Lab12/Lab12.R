#Lab12

#We can use rpois
#lambda would be what the original equation gives you at every point
#In other words the changing n
StochastPop <- function(r = 0.1, k = 100, gens = 100, n_init = 10) {
  poplist <- rep(0, gens)
  poplist[1] <- n_init
  for (t in seq(1:(gens-1))) {
    nval = poplist[t] + r * poplist[t] * (k - poplist[t])/k
    poplist[t+1] <- rpois(1, lambda=nval) 
  }
  plot(seq(1,gens), poplist, xlab = "Generations", ylab = "Abundance", type = "l")
  return(poplist)
}

#The plot is contained in the above function
x <- StochastPop()

#x[1] is the initial 10
#lambda needs to be calculated from x[2]
#y is the realized n[2] value
y <- rpois(1, x[2])
increase <- ppois(x[1], y, lower.tail = FALSE)
#The probability of getting the same n[1] value despite the realized
same <- dpois(x[1], y)
#The prob of it being smaller
decrease <- ppois(x[1], y, lower.tail = TRUE) - same

#probabilty that n[2] is between 15 and 25 (inclusive)
#betval <- dpois(15:25, y)

print(increase)
print(decrease)
print(same)
print(sum(same,increase,decrease))

#print(betval)
