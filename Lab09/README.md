# Lab 09 Description

### PROBLEM 1
We use POSIXct to convert the sixth column to proper time stamps that can then be turned to numeric values.

Then we can convert the difference in time to days ( a decimal value ).

### PROBLEM 2
This takes in a file name (in quotes with a .csv present) as well as a placement, season, and station. It then turns the placement, season, and station columns from the csv into vectors.

The placement entered is located in the respective column and then the indeces are collected. Then we do the same for the other values and then find the indeces where they intersect, and then use these intersections to collect the times we need from the date-time column

Once the times are collected we use our previous function to calculate all of the differences (in days) and then place them in a vector, which is then returned.

 
