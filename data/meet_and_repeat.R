# Matilda K
# 11.12.2013
# Data wrangling part of assignment 6 in IODS2023 course
# We use two datasets. First one includes information on 40 male subjects 
# that were randomly assigned to one of two treatment groups and rated on 
# the brief psychiatric rating scale (BPRS) before treatment and once a week 
# after treatment for eight weeks. BPRS measures different symptoms related to schizophrenia.
# The second dataset consists of data from a nutrition study performed on tree groups of rats that
# were put on different diets. Each rats body weight was measured weekly (except twice on week seven).

# 1.
# Load the datasets:
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Take a look at the datasets
glimpse(BPRS)
View(BPRS)
summary(BPRS)
glimpse(RATS)
View(BPRS)
summary(BPRS)

# Variable names:
colnames(BPRS) #"treatment" "subject" "week0" "week1" "week2" "week3" "week4" "week5" "week6" "week7" "week8"    
colnames(RATS) #"ID" "Group" "WD1" "WD8" "WD15" "WD22" "WD29" "WD36" "WD43" "WD44" "WD50" "WD57" "WD64"

# 2.
# Convert the categorical variables of both data sets to factors
# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3.
# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS
# Convert BPRS to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

# Convert RATS data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)

# 4. 
# Now, take a serious look at the new data sets and compare them with their wide form versions: 
# Check the variable names:
colnames(BPRSL)
colnames(RATSL)

#view the data contents and structures, 
glimpse(BPRSL)
View(BPRSL)
glimpse(RATSL)
View(RATSL)

#and create some brief summaries of the variables.
summary(BPRSL)
summary(RATSL)

# Write the wrangled datasets to files in data-folder:
write_csv(BPRSL, "./data/BPRSL.csv")
write_csv(RATSL, "./data/RATSL.csv")
