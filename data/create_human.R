# Matilda K
# 26.11.2013
# Data wrangling part of assignment 4 in IODS2023 course
# Metadata on the datasets used in this scripts are found here:
# https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
# and here:
# https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

# Read in data:
library(readr)
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
"#hd column/variable names:
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
 #The second new variable should be the ratio of labor force participation 
 #of females and males in each country (i.e., Labo.F / Labo.M).
 
 
 
 
 
 #Join together the two datasets using the variable Country as the identifier.
 #Keep only the countries in both data sets (Hint: inner join). The joined data
 #should have 195 observations and 19 variables. Call the new joined data "human" 
 #and save it in your data folder (use write_csv() function from the readr package). 
