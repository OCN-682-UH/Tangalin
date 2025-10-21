### This is my ggplot for Week_03 assignment. ####
### Created by: Natalia Tangalin ####
### Created on: 2025-12-09 ####
### Last updated: 2025-16-09 ###

### Libraries #####
library(palmerpenguins)
library(tidyverse)
library(here) 
library(devtools) ### used to upload non-R inhouse packages
library(usethis) ### R said "Loading required package: usethis" for devtools
library(ghibli)  ### there is ghibli_colors in R but wanted to try CRAN
library(ggthemes) ### lots of preset options for clean graphs


### Load data #####
# The data is part of the package and is called penguins
glimpse(penguins)


ggplot(data = penguins,                   # call ggplot in
       mapping = aes(x = bill_depth_mm,   # x = bill depth
                     y = bill_length_mm,  # y = bill length
                     group = species,     # groups the 3 species
                     color = species)) +  # each species point 1 color
  geom_boxplot()+                         # gives a boxplot
  coord_trans(x = "log10", y = "log10") +  # Apply log10 transformation to both axes
  labs(x = "Bill depth (mm)",          # adds axes labels with units
       y = "Bill length (mm)",
       title = "Penguins"              # add a graph title
  )+
  scale_colour_ghibli_d("LaputaMedium", direction = -1) + 
  theme_minimal() + # clean pre-package theme I like
  theme(
    plot.title = element_text(size = 16, hjust = 0.5, face = "bold"), #centers and bolds title
    axis.title = element_text(size = 14,    # changes axes font size
                                  color = "black"), # changes axes label color
        panel.background = element_rect(fill = "white")) #background color

   
  ### Analysis #####
