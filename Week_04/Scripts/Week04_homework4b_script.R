### This is my homework for Week_04b assignment with biogeochemistry data from Hawaii ####
### Created by: Natalia Tangalin ####
### Created on: 2025-22-09 ####
### Last updated: 2025-23-12 ###


#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
ChemData<-read_csv(here("Week_04","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_clean<-ChemData %>%
  drop_na() %>% #drops rows with NAs
  separate(col = Tide_time, # choose the tide time col to separate
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by_ add _,remove = FALSE) # keep the original column
           remove = FALSE) %>% # keep the original tide_time column
unite(col = "Site_Zone", # the name of the NEW col
      c(Site, Zone), # the columns to unite
      sep = ".", # puts a dot in the middle
      remove = FALSE) # keep the orginal
ChemData_filtered <- ChemData_clean %>%
  filter(Season == "FALL", Time == "Day", Zone == "Diffuse") #filter by season = FALL, Time = Day, and Zone = Diffues
view(ChemData_filtered) #see new filterd table
ChemData_long <- ChemData_filtered %>%
  pivot_longer(cols = c(Temp_in, Salinity, Phosphate, Silicate, NN, pH, TA, percent_sgd), # only measurment columns
               names_to = "Variables", #fix error message Column `Variables` doesn't exist.
               values_to = "Values")
ChemData_wide <- ChemData_long %>%
  pivot_wider(names_from =  Variables, # column with name
              values_from = Values) #column with values
View(ChemData_wide) #see the wide data
ChemData_summary <- ChemData_wide %>% #make ChemData_summary
  group_by(Site_Zone) %>%  # Group calcs by Site_Zone
  summarise(   #make a summary of gorup data
      mean_percent_sgd = mean(percent_sgd, na.rm = TRUE), #the mean for percent_sgd or relative amount of submarine groundwater discharge in the water,%
      mean_TA = mean(TA, na.rm = TRUE), #the mean for TA
      mean_pH = mean(pH, na.rm = TRUE), #the mean for pH
      mean_Phosphate = mean(Phosphate, na.rm = TRUE), #the mean for phosphate
      mean_NN = mean(NN, na.rm = TRUE) #the mean for nitrate
  )
View(ChemData_summary)#should have gone long and just calc there, think I missed the point
write.csv(ChemData_summary, file = "ChemData_summary.csv", row.names = FALSE)
write.csv(ChemData_summary, file = here("output", "ChemData_summary.csv"), row.names = FALSE) #saves and takes out row names to declutter
ggplot(ChemData_summary, aes(x = mean_percent_sgd, y = mean_pH, color = Site_Zone)) +
     geom_point(size = 3) + # Add points
     geom_smooth(method = "lm", se = FALSE) + # Add a linear regression line
     labs(title = "Mean pH vs. Mean Percent SGD for Daytime in the Fall and the Diffuse Zone", #title
              x = "Mean Percent Submarine Groundwater Discharge (%)", #label Axes
              y = "Mean pH") +
theme_minimal() 
print(plot) #see data
ggsave("C:/Users/Ainacology/OneDrive/Desktop/Repositories/Tangalin/Week_04/Output/plot_mean_pH_vs_mean_percent_sgd_.jpg", width = 8, height = 6) #saves to Output folder in Week_04, should use here ?-ggsave(here("Week_4", "output", "plot_mean_pH_vs_mean_percent_sgd.jpg"), plot = plot) cannot find directory?


### Analysis #####