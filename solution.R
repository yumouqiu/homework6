HAPPY = readRDS("data/HAPPY.rds")
str(HAPPY)

HAPPY[HAPPY == "IAP"] = NA
HAPPY[HAPPY == "DK"] = NA
HAPPY[HAPPY == "NA"] = NA

HAPPY$AGE[HAPPY$AGE == "89 OR OLDER"] = 89
HAPPY$AGE = as.numeric(HAPPY$AGE)






# Clean the data by dplyr package

library(tidyverse)
HAPPY = readRDS("data/HAPPY.rds")

HAPPY = HAPPY %>% mutate(
  happy = factor(tolower(HAPPY))
) %>% select(-HAPPY)

HAPPY = replace(HAPPY, HAPPY == "IAP", NA)
HAPPY = replace(HAPPY, HAPPY == "DK", NA)
HAPPY = replace(HAPPY, HAPPY == "NA", NA)

HAPPY = HAPPY %>% mutate(
  age = replace(AGE, AGE == "89 AND OLDER", 89),
  age = as.numeric(age)
) %>% select(-AGE)

HAPPY %>% ggplot(aes(x = age)) + geom_histogram(binwidth=1)

HAPPY <- HAPPY %>% mutate(
  degree = factor(tolower(DEGREE)),
  degree = factor(degree, levels=c("lt high school", "high school", "junior college", "bachelor", "graduate school"))
) %>% select(-DEGREE)

HAPPY %>% ggplot(aes(x = degree)) + geom_bar()


#--- This is an old code
# HAPPY1 =
#   HAPPY %>% mutate(AGE = replace(AGE, AGE == "89 OR OLDER", 89)) %>%
#   mutate(AGE = as.numeric(AGE),
#          HAPPY = as.factor(HAPPY),
#          SEX = as.factor(SEX),
#          MARITAL = as.factor(MARITAL),
#          DEGREE = as.factor(DEGREE)) %>%
#   mutate(DEGREE = factor(DEGREE, levels = c("LT HIGH SCHOOL",
#                                             "HIGH SCHOOL" ,
#                                             "JUNIOR COLLEGE",
#                                             "BACHELOR",
#                                             "GRADUATE")))

# Working with the cleaned data from "classdata" library

library(classdata)
data("happy", package="classdata")
head(happy)
str(happy)

happy.age = happy %>% 
  group_by(age) %>% 
  summarise(m.age = mean(as.numeric(happy), na.rm = TRUE)) 

happy.age %>% 
  ggplot(aes(x = age, y = m.age)) + geom_point()

happy.party = happy %>% 
  group_by(partyid) %>% 
  summarise(m.partyid = mean(as.numeric(happy), na.rm = TRUE)) 

happy.party %>% 
  ggplot(aes(x = partyid)) + geom_bar(aes(weight = m.partyid))

