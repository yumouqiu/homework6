happy = readRDS("data/HAPPY.rds")
str(happy)

happy[happy == "IAP"] = NA
happy[happy == "DK"] = NA
happy[happy == "NA"] = NA

happy$AGE[happy$AGE == "89 OR OLDER"] = 89
happy$AGE = as.numeric(happy$AGE)

# Clean the data by dplyr package

library(tidyverse)
happy = readRDS("data/HAPPY.rds")

happy = replace(happy, happy == "IAP", NA)
happy = replace(happy, happy == "DK", NA)
happy = replace(happy, happy == "NA", NA)

happy1 = 
  happy %>% mutate(AGE = replace(AGE, AGE == "89 OR OLDER", 89)) %>%
  mutate(AGE = as.numeric(AGE), 
         HAPPY = as.factor(HAPPY), 
         SEX = as.factor(SEX), 
         MARITAL = as.factor(MARITAL), 
         DEGREE = as.factor(DEGREE)) %>%
  mutate(DEGREE = factor(DEGREE, levels = c("LT HIGH SCHOOL", 
                                            "HIGH SCHOOL" , 
                                            "JUNIOR COLLEGE", 
                                            "BACHELOR", 
                                            "GRADUATE")))


