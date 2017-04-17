## Bees, Pesticides, and Foraging -- Independent Project
#### Chronic impairment of bumblebee natural foraging behaviour induced by sublethal pesticide exposure
##### Surabhi Nair
----------

##### **Background**
"Chronic impairment of bumblebee natural foraging behaviour induced by sublethal pesticide exposure" (2014) by Richard J. Gill and Nigel E. Raine was a study performed over 4 weeks in England documenting how pesticide exposure affected foraging in bumblebees (Bombus terrestris).

The study tested the effects of two different pesticides and their combined effect. The researchers found that the bees overall "showed a decrease in pollen foraging efficiency ... with their performance increasingly diverging away from that of control bees as the experiment progressed" (Gill et al, 2014) as well as a decrease in the pollen loads carried by the bees. 

##### **Methodology and Datasets**
The researchers observed the effects of the pesticides imidacloprid, λ-cyhalothrin, and a mixture of the two on several bumblebee colonies over the course of 4 weeks. For each of these treatments and the control, they measured the amount of time a bee would spend foraging, the amount of pollen a bee would collect, how often they would forage, and the type of pollen collected (color based). 

The data which was made available through Dryad Data Repository contains two excel spread sheets, one containing foraging data recorded throughout the period, and the other containing information on pollen load carried as well as the type of pollen. 

*Inconsistencies*
For the recorded foraging time in the Foraging_duration.xlsx spreadsheet, some of the durations have 'AM' after them, even though they denote lengths of time and not timestamps. These will need to be removed while parsing the data.

##### **My Project**
For this project, I will be repeating the analysis of determining which pesticide has more of an effect on bee foraging as well as whether or not the type of pollen (thus indicating the type of flower) that bees preferred changed after pesticide exposure, and which pesticide(s) were involved. 

I would also like to expand on the study a bit by using a Poisson distribution model to model the amount of pollen brought in by each bee for each pesticide treatment. The researchers used a Poisson distribution for the number of foragers and the number of foraging bouts, but didn't do so for the pollen data.

----------
##### **Acknowledgements**
Gill RJ, Raine NE (2014) Chronic impairment of bumblebee natural foraging behaviour induced by sublethal pesticide exposure. Functional Ecology 28(6): 1459-1471.
[Here is the publication](http://onlinelibrary.wiley.com/doi/10.1111/1365-2435.12292/full)
[Here is the dryad repo](http://datadryad.org/resource/doi:10.5061/dryad.kv558)
