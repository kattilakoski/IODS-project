# date: 10.11.2023
# author: Matilda Kattilakoski
# description: Data wrangling part of assignment 2 on the IODS2023 course.

# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)


#Create analysis dataset with the variables gender, age, attitude, deep, stra, surf and points

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude

# divide each number in the column vector
lrn14$Attitude / 10

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

#Create analysis dataset with the variables gender, age, attitude, deep, stra, surf and points
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

#set working directory to IODS-project folder:
setwd("C:/Users/Tohtorikurssit/IODS2023/IODS-project")

write_csv(learning2014, "C:/Users/Tohtorikurssit/IODS2023/IODS-project/data/learning2014.csv")
learning2014 <- read_csv("C:/Users/Tohtorikurssit/IODS2023/IODS-project/data/learning2014.csv")
str(learning2014)
head(learning2014)