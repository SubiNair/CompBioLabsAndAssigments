## Exposure to pesticides impairs the ability of bumblebees to forage for pollen

#### Surabhi Nair
----------
### Question
#### Can we predict how bumblebee foraging is affected by exposure to pesticides? 

### Introduction
Bumblebees are incredibly important to their ecosystems. They are key pollinators and are responsible for pollinating many of our staple crops. The use of certain insecticides to kill pests also affects the bees who share their habitat. 
The pesticides we put into our environment have a direct effect on our ecosystems and the growing rate of bumblebee death is just an example of that. The study here intended to focus on the effects of two specific pesticides on bumblebees and their ability to functionally forage for pollen if they are exposed to sublethal amounts of the toxins.

### Methods
##### Data Source
The data was generated in the paper "Chronic impairment of bumblebee natural foraging behaviour induced by sublethal pesticide exposure" by Richard J. Gill and Nigel E. Raine. The experiment involved 4 different pesticide treatments being tested on Bombus terrestris (bumblebees) to determine the deteriorating effects over time on foraging behaviors and learning. 

The [publication can be found here](http://onlinelibrary.wiley.com/doi/10.1111/1365-2435.12292/full) and the data is in [the dryad repository](http://datadryad.org/resource/doi:10.5061/dryad.kv558)

The data was produced by taking bees from several colonies and exposing them to specific treatments. The bees were then measured over a span of roughly two months on their ability to forage effectively for pollen. This included how long they stayed out, and how much pollen they carried back with them, as well as the type of pollen they carried with them. 

The data was contained in two .xlsx files, one for Foraging Data which was 98.22 Kb, and one for pollen data which was 47.17 Kb. 

##### Original Study
The foraging data was used to create regression models on how often bees would forage and how many bees would forage if still alive after exposure. They also used the pollen data to produce analyses on how much pollen the bees would carry back. The pollen loads were measured in discrete values from 0 to 3, where 3 indicates a large amount of pollen relative to the size of the actual bee. Additionally they tested to see if there were significant differences in the preferences of the bees with the flowers that they chose. They recorded the flower preferences by the types of pollen they found, identified mostly by color. For the pollen data they found that imidacloprid tended to hinder bees the most, and tended to alter their preferences in flowers the most as well. 

##### My Project and Analysis 
I recreated some of the original analyses, by creating regressions based on the average number of foraging bouts per day and the average pollen score per day for each of the treatments. I also created barplots of the bees flower preferences with each treatment. 

I also did some of my own Poisson distribution analysis by using the dpois function in R to model the exact probabilities of a bumblebee bringing back a certain amount of pollen for each of the treatments.  The researchers had used a Poisson distribution to model the number of foragers and the foraging bouts but they didn't apply the model to the pollen data, which is what I was more focused on for this project. 

### Results and Conclusions
The treatments are listed as A, B, C, D, which denote the LC (λ-cyhalothrin), M (The mix of the two), The Control, and I (imidacloprid) respectively. 

In the original study, some of the most immediately damaging effects on the bees were the result of imidacloprid exposure.

What I found through my Poisson distribution analysis was that for the treatments B and D, the probability of a bee bringing back a moderate to high pollen load plummeted. Pollen load is relative to the size of the bee and what this indicates is, during the observed time period, a bee that has received either one of these treatments has great difficulty carrying a sufficient amount of pollen. Both of these treatments contain imidacloprid. For treatment B, the chances of a bee bringing back a size 3 load of pollen dropped to a probability of 0.07778285, whereas in the control it is 0.1946612. 

![B Poisson Values](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/BPoisson.png "B Poisson Values")

![D Poisson Values](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/DPoisson.png "D Poisson Values")

This is strong additional evidence to suggest that imidacloprid specifically harms bees ability to forage effectively. 

The Control and the LC treatment respectively:
![C Poisson Values](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/CPoisson.png "C Poisson Values")

![A Poisson Values](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/APoisson.png "A Poisson Values")


For the analysis that I repeated, I decided to visualize the flower preference results in a bar plot instead of a pie chart, and I used only the top 4 flowers visited. 

The imidacloprid treatments displayed a stronger preference for AU2 (Which based on the supplementary materials from the original study seem to be Dahlia which would be in line with their results). The chart contains the flower preferences for the I treatment.

![D Flower Pref](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/DFlowerPref.png)

The LC Treatments:

![A Flower Pref](https://github.com/SubiNair/CompBioLabsAndAssigments/blob/master/Assignment11/AFlowerPref.png)


