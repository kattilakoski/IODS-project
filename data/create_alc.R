# Matilda K
# 20.11.2013
# Data wrangling part of assignment 3 in IODS2023 course
# Data used is student performance data from UCI Machine Learning Repository: https://www.archive.ics.uci.edu/dataset/320/student+performance

#install packages:
# install.packages("boot")
# install.packages("readr")

# access libraries
# library(dplyr); library(ggplot2); library(readr); library(tidyr); library(boot)

# Read both student-mat.csv and student-por.csv into R (from the data folder) 
mat <- read.table("./data/student-mat.csv", sep=";", header=TRUE)
por <- read.table("./data/student-por.csv", sep=";", header=TRUE)

# explore the structure  
str(mat) 
str(por) 


# and dimensions of the data 
dim(mat)
dim(por)

# Both files are data frames: student-por.csv has 649 observations and 33 variables 
# and student-mat.csv has 395 observations and 33 variables. Both data frames have 
# observations on variables such as age, address and studytime.



# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" 
# as (student) identifiers. Keep only the students present in both data sets. Explore the structure and
# dimensions of the joined data.

# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))

#structure and dimensions
glimpse(mat_por)
dim(mat_por)
str(mat_por)
#The data frame now includes 370 observations and 39 variables(including just created .mat and .por ending variables)
#and only the students that are present in both datasets.



# Get rid of the duplicate records in the joined data set:

# print out the column names of 'math_por'
colnames(mat_por)

# create a new data frame with only the joined columns
alc <- select(mat_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
setdiff(colnames(mat_por), join_cols)
free_cols
# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(mat_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
glimpse(alc)



# Take the average of the answers related to weekday and weekend alcohol consumption to create 
# a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' 
# which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise).

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)



# Glimpse at the joined and modified data to make sure everything is in order. The joined data should 
# now have 370 observations. Save the joined and modified data set to the ‘data’ folder, using 
# for example write_csv() function (readr package, part of tidyverse).

glimpse(alc) # Data frame includes 370 rows/observations and 35 columns/variables so everything is in order. 
# New columns alc_use, and high_use are found in the data frame and the .mat and .por ending variables 
#are not there anymore.

#save the data set
write_csv(alc, "./data/student_alc.csv")
