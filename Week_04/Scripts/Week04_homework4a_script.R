### This is my homework for Week_04a assignment. ####
### Created by: Natalia Tangalin ####
### Created on: 2025-21-09 ####
### Last updated: 2025-21-12 ###

### Libraries #####
library(palmerpenguins) #data set used
library(tidyverse) # to manipulate data
library(here) # for paths, loaded but do not think used
library(ggplot2) # to plot
library(ggthemes) ### lots of preset options for clean graphs, loaded not used

### Load data #####
# The data is part of the package and is called penguins
glimpse(penguins)
#part 1
penguin_stats <- penguins %>% # use penguin dataframe and create Penguin_stats
  drop_na(body_mass_g, species, island, sex) %>% # remove the NAs
  group_by(island, species, sex) %>% #groups by island, species,sex
  summarise(mean_body_mass_g = mean(body_mass_g, na.rm=TRUE), .groups = 'drop') # cal mean, drop variance not grouped to penguin data for variance 
penguin_variance <- penguins %>%  
  drop_na(body_mass_g, species, island, sex) %>% # remove the NAs
  group_by(island, species, sex) %>% #groups by island, species,sex
  summarise(variance_body_mass_g = var(body_mass_g, na.rm=TRUE), .groups = 'drop') #cal variance of body mass
final_stats <-left_join(penguin_stats, penguin_variance, by = c("island", "species", "sex")) # joins mean and variance
print(final_stats) #prints it out but can't see mean and variance, but notes it is there
##Part2
penguin_data <- penguins %>% # use penguin dataframe
  drop_na(body_mass_g, species, island, sex) %>% # remove the NAs
  filter(sex != "male") %>% ### part 2, filter out male
  mutate(log_body_mass_g = log(body_mass_g)) %>% #cal log of body mass
  select(species, island, sex, log_body_mass_g) # select columns
print(final_stats)#see data
ggplot(penguin_data, aes(x = species, y = log_body_mass_g, fill = island)) + # sets aesthetics of plot
  geom_boxplot() + # makes a boxplot 
  labs(title = "Female Penguins", # plot title
       x = "species", # label x axis
       y = "Log Body Mass (g)", # label y axis
       fill = "Island")+ # legend title for fill of boxes with color by island
  theme_light() #chosen theme
# Save plot
ggsave("C:/Users/Ainacology/OneDrive/Desktop/Repositories/Tangalin/Week_04/Output/female_penguin_log_body_mass_plot.jpg", width = 8, height = 6) #saves to Output folder in Week_04
  

### Analysis #####