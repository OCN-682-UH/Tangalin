### This is my homework for Week_05 assignment. ####
### Created by: Natalia Tangalin ####
### Created on: 2025-09-29 ####
### Last updated: 2025-30-29 ###

#### Load Libraries ######
library(tidyverse)
library(here)
library(lubridate)

### Load data ######
library(lubridate) #load lubridate #for dates and times
library(tidyverse) #load tidyverse 
library(here) #load here

CondData <- read_csv(here("Week_05","data", "CondData.csv")) %>% # read conductivity in data
  mutate(date = mdy_hms(date)) %>%  #convert date column to datetime mdy:hms
  mutate(datetime = round_date(date, "10 seconds")) %>% #round to the nearest 10 seconds
  mutate(minute = round_date(datetime, "minute")) %>%   #round to nearest minute
  mutate(date_only = as_date(datetime), #extract just the date
         time_only = format(datetime, "%H:%M:%S")) #extract time in hour-minute-seconds

View(CondData) # view rounded data
  
DepthData <- read_csv(here("Week_05","data", "DepthData.csv")) %>% # read in depth data
  mutate(datetime = date) %>% #seems like I need this 
  mutate(minute = round_date(datetime, "minute")) %>% #round to nearest minute already rounded to 10 sec
    mutate(date_only = as_date(datetime),# extract date
           time_only = format(datetime, "%H:%M:%S")) #extract time
View(DepthData) # view rounded data 
   
#Join data sets, average variables and graph
SummarizebyMinute <-CondData %>% 
  inner_join(DepthData, by = "datetime") %>% #join data sets by datetime
  mutate(minute = round_date(datetime, "minute")) %>% 
  group_by(minute) %>% #group minute
  reframe( # Please use `reframe()` instead.summarise(
    date = as_date(minute), #extract date from each minute
    Depth = mean(Depth, na.rm = TRUE),#cal average depth for each min w/no NAs
    Temperature = mean(Temperature, na.rm = TRUE), #cal ave. temp for each min no NAs
    Salinity = mean(Salinity, na.rm = TRUE)) %>%  #cal ave. salinity for each min no NAs
  pivot_longer(cols = c(Depth, Temperature, Salinity), #one row for each 
               names_to = "Variable", #variable column with Temp, Depth, Sal
               values_to = "value") %>%  #makes value column for measurements
  ggplot(aes(x = minute, y = value, color = Variable)) + #plot time for each variable
  geom_line() +  #lines for each variable
  labs(
    title = "Average Depth, Temp, and Salinity per Minute", #plot title
    x = "Time (minute)", #x-axis label
    y = "Value", #y axis label
    color = "Variable") + #labels colors to be variables
  theme_minimal()

SummarizebyMinute

ggsave("MinuteSummaryPlot.png", plot = SummarizebyMinute, width = 10, height = 6, dpi = 300)




