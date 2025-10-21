### This is my first script.  I am learning how to import data ####
### Created by: Natalia Tangalin ####
### Created on: 2025-09-07 ####
### Last updated: 2025-09-07

### libraries #####
library(tidyverse)
library(here)


### Read in my data #####
weightData<-read_csv(here("Week_02","Data","weightdata.csv"))


# analysis #####
head(weightData)
tail(weightData) ## looks at the bottom 6 lines
view(weightData)
