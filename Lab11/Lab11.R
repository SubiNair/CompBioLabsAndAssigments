#Lab11

rbinom(n = 1, size = 10, prob = 0.5)
rbinom(n = 8, size = 10, prob = 0.5)


#15% if you do get the vaccine
vacc <- rbinom(n = 1, size = 20, prob = 0.15)
print(vacc)

#40% if you do NOT get the flu vaccine
unvacc <- rbinom(n = 1, size = 20, prob = 0.4)
print(unvacc)

#do the same thing with replicates
rep_vac <- rbinom(n = 30, size = 20, prob = 0.15)
print(rep_vac)
rep_unvacc <- rbinom(n = 30, size = 20, prob = 0.4)
print(rep_unvacc)
hist(rep_vac, main = "Vaccinated, 30 replicates")
hist(rep_unvacc, main = "Unvaccinated, 30 replicates")

#Moving forward 1 generation with allele a
init_size = 500
a_one_gen <- rbinom(n = 1, size = 500, prob = 0.55)
print(a_one_gen)
new_prob <- a_one_gen / init_size
next_gen_freq <- rbinom(n = 1, size = a_one_gen, prob = new_prob)
print(next_gen_freq)

#Now going forward 1000 generations, we need to find a new prob each time
t_prob = 0.55
t_size = 500
final_a <- rep(0, 1000)

for(i in seq(1,1000)) {

  success_offspring <- rbinom(n = 1, size = t_size, prob = t_prob)
  final_a[i] <- success_offspring
  
  #Updating the probability based on the number of successes
  t_prob <- success_offspring / t_size
  
}

print(final_a)
plot(seq(1,1000), final_a, xlab = "Generations", ylab = "Frequency of Allele 'a'", type = "l" )

#One of the alleles will go to fixation
z_prob = 0.55
z_size = 500
final_a_z <- matrix(data = 0, nrow = 1000, ncol = 100)

for(i in seq(1,1000)) {
  
  success_offspring <- rbinom(n = 1, size = t_size, prob = t_prob)
  final_a_z[i, j] <- success_offspring
  
  #Updating the probability based on the number of successes
  t_prob <- success_offspring / t_size
  
}

