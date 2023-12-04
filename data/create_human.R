# Matilda K
# 26.11.2013
# Data wrangling part of assignment 4 in IODS2023 course
# Metadata on the datasets used in this scripts are found here:
# https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# and here:
# https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

#access libraries:
library(tidyverse)
library(readr)

# Read in data:
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the datasets
# structure
str(hd)
str(gii)

# dimensions
dim(hd)
dim(gii)

#summaries
summary(hd)
summary(gii)

# Rename the variables with (shorter) descriptive names
colnames(hd) = c("HDI.rank", "country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.HDI")

"hd column/variable names:
"HDI.rank" = "HDI rank"
"country" = "country
"HDI" = "Human development index"
"Life.Exp" = "Life expectancy at birth"
"Edu.Exp" = "Expected years of schooling"
"Edu.Mean" = "Mean years of education"
"GNI" = "Gross National Income per capita"
"GNI.HDI" = "GNI per capita rank minus HDI rank"

colnames(gii) = c("GII.rank", "country", "GII", "Mat.Mor", "Ado.Birth", "Parli", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

#gii column/variable names:
"GII.rank" = " GII Rank"
"country" = "Country"
"GII" = "Gender Inequality Index"
"Mat.Mor" = "Maternal Mortality Ratio"
"Ado.Birth" = "Adolescent Birth Rate"
"Parli" = "Percent Representation in Parliament"        
 "Edu2.F" = "Population with Secondary Education (Female)"
 "Edu2.M" = "Population with Secondary Education (Male)"
 "Labo.F" = "Labour Force Participation Rate (Female)"
 "Labo.M" = "Labour Force Participation Rate (Male)"
 
 
 #Mutate the “Gender inequality” data and create two new variables. 
 #The first new variable should be the ratio of female and male populations 
 #with secondary education in each country (i.e., Edu2.F / Edu2.M). 
gii <- mutate(gii, Edu2.FM = (Edu2.F / Edu2.M))

 #The second new variable should be the ratio of labor force participation 
 #of females and males in each country (i.e., Labo.F / Labo.M).
gii <- mutate(gii, Labo.FM = (Labo.F / Labo.M))
 
 
 #Join together the two datasets using the variable Country as the identifier.
 #Keep only the countries in both data sets (Hint: inner join). The joined data
 #should have 195 observations and 19 variables. Call the new joined data "human" 
 #and save it in your data folder (use write_csv() function from the readr package). 
hd_gii <- inner_join(hd, gii, by = "country")
dim(hd_gii) # 195  19

write_csv(hd_gii, "./data/human.csv")






### Week 5 Data wrangling

# load the data
human <- read_csv("./data/human.csv")

# 1. 

# explore dimensions and structure:
dim(human) #195 obs. 19 var.
str(human)

# Brief description of the dataset:
# The dataset includes information on health, knowledge and empowerment of citizens from 195 countries. The dataset includes
# 19 variables. The shortened versions are explained earlier in this document. The human development index (HDI) combines three
# dimensions: long and healthy life, knowledge, and a decent standard of living. The gender development index (GDI) includes
# information on gender inequalities.

# 2.
# Exclude unneeded variables:
keep <- c("country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli")
# select the 'keep' columns
human <- select(human, one_of(keep))

# 3.
# Remove all rows with missing values
human <- filter(human, complete.cases(human))

# 4.
# Remove the observations which relate to regions instead of countries.
install.packages("countries")
library(countries)
human <- filter(human, is_country(human$country, check_for = NULL, fuzzy_match = TRUE))

# 5.
# The data should now have 155 observations and 9 variables (including 
# the "Country" variable). Save the human data in your data folder. You can 
# overwrite your old ‘human’ data.
# At this point I had 156 observations so I checked the provided file and 
# the Arab states was not in that so I will remove it from my human dataframe.
check <-  read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human2.csv")
human <-subset(human, country != "Arab States")

write_csv(human, "./data/human.csv")
