#PART I
#lab step #3
#These are variables storing the number of guests & how many bags of chips we have
numOfGuests <- 8
chipBags <- 5

#lab step #5: Variable storing how many bags of chips you expect each person to eat
expectedConsump <- 0.4

#lab step #7: totalConsump to calculate how many chip bags you and the guests will eat
#remainingChips is to then see how many chip bags remain afterwards
totalConsump <- (numOfGuests + 1) * expectedConsump
remainingChips <- chipBags / totalConsump


#PART II
#lab step #8
#vectors containing every persons rankings of the films, with the first element corresponding to Episode I and so on
Self <- c(7, 6, 5, 1, 2, 3, 4)
Penny <- c(5, 7, 6, 3, 1, 2, 4)
Jenny <- c(4, 3, 2, 7, 6, 5, 1)
Lenny <- c(1, 7, 3, 4, 6, 5, 2)
Stewie <- c(6, 7, 5, 4, 3, 1, 2)

#lab step #9
#variables that store Penny and Lenny's ranking of the 4th Episode
PennyIV <- Penny[4]
LennyIV <- Lenny[4]

#lab step #10
#Concatenating all of the rankings into filmRankTable
filmRankTable <- cbind(Self, Penny, Jenny, Lenny, Stewie)

#lab step #11
#This is to see the structure of the following variables and data object
str(PennyIV)
str(Penny)
str(filmRankTable)

#The structure for PennyIV and Penny is num, for filmRankTable there are multiple results
#It says the following:
#num [1:7, 1:5] 7 6 5 1 2 3 4 5 7 6 ...
#- attr(*, "dimnames")=List of 2
#..$ : NULL
#..$ : chr [1:5] "Self" "Penny" "Jenny" "Lenny"
#The NULL is due to not having names for the rows, but the columns have names of type chr

filmDataFrame <- data.frame(Self, Penny, Jenny, Lenny, Stewie)
filmAsDataFrame <- as.data.frame(filmRankTable)

str(filmDataFrame)
str(filmAsDataFrame)

dim(filmDataFrame)
dim(filmAsDataFrame)
dim(filmRankTable)

typeof(filmDataFrame)
typeof(filmAsDataFrame)
typeof(filmRankTable)

#When using typeof() both of the data frames are lists, but the cbind matrix gives you "double"
#dimensions simply provides you with the number of rows and then columns which in every case is 7 5
#structure for all of these says num

filmRankTable == filmDataFrame
filmDataFrame == filmAsDataFrame
filmRankTable == filmAsDataFrame

# == confirms that the values are the same throughout the matrix and the data frames
# All values are listed as TRUE

#lab step #14
#We are making a vector of the Episode names
epNames <- c("I", "II", "III", "IV", "V", "VI", "VII")

#Now we can add this to the data frames
row.names(filmDataFrame) <- epNames
row.names(filmAsDataFrame) <- epNames
row.names(filmRankTable) <- epNames


#Accessing elements of matrices and data frames
#step 16
filmRankTable[3,]

#step 17
filmDataFrame[,4]

#step 18
filmDataFrame[5,1]

#step 19
filmDataFrame[2,2]

#step 20
filmDataFrame[4:6,]

#step 21 -- accessing specific rows
filmDataFrame[c(2,5,7),]

#step 22 -- accessing specific rows and columns
filmDataFrame[c(4,6),c(2,3,5)]

#lab step 23
#we are going to switch two of Lenny's rankings using an intermediate variable
#so we can store one and then replace the original
swapRank <- filmDataFrame[2,4]
filmDataFrame[2,4] <- filmDataFrame[5,4]
filmDataFrame[5,4] <- swapRank

#lab step 24
#Access through row and column names
filmRankTable["III", "Penny"]
filmDataFrame["III", "Penny"]

#Now we can undo the switch we made earlier
swapRank2 <- filmDataFrame["V", "Lenny"]
filmDataFrame["V", "Lenny"] <- filmDataFrame["II", "Lenny"]
filmDataFrame["II", "Lenny"] <- swapRank2

#lab step 26
#We are redoing the swap with the $ operator
swapRank3 <- filmDataFrame$Lenny[2]
filmDataFrame$Lenny[2] <- filmDataFrame$Lenny[5]
filmDataFrame$Lenny[5] <- swapRank3

