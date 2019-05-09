library(tidyverse)

#################   Reshaping Data   #################

# import data from the the "data" folder within our R project
data_wide <- 

# key = the name we want for a new column which is created by extracting the column names we want to gather together.

# value = the variable name for the data we are gathering in this example we have anxiety scores for subjects across many different conditions

# After those arguments, we tell the gather function the names of all of the columns we want to gather. It easier to say gather everthing except for id
data_long <- 

# This is the opposite of gather
# convert data to wide format
# key = the name of the column in our data that we want to be the names of our new columns
# val = the data that needs to be spread out
# NOTE: we don't need quotation marks because these columns already exist!
data_wide_gathered <- 

#################   Into to the dplyr package   #################

# import data from the the "data" folder within our R project
superhero_dat <- 

# change the first variable name
superhero_dat <- rename(superhero_data,
                        Id = X1)

# Take a peak at the data
str(superhero_dat) # provides more information about the structure
glimpse(superhero_dat, width = 80)

# Try out filter and create a subset of all of the good heroes
# HINT: it be helpful to use the function distinct from the cheat sheet to check all unique values of a column within a tibble/data.frame
distinct(superhero_dat, Alignment)


# Try out select and remove the first column from the superhero dataset



# Try out select and and create a subset of only the variables which contain the word "color"
# HINT: use the cheat cheet and find the helper functions in the upper rigth corner of page 1



# Try out mutate to convert weight from lbs to kgs, height from cm to m, and then use the new variables to compute each hero's BMI



# Try out group_by and summrise together
# Group the superhero data by Gender (we can overwrite our "old" data because group_by doesn't change anything)
superhero_dat <- 
  
  # Find the average heigt of each group
  
  
  
  #################   Data Pipeline   #################
# - create intermediate objects
superhero_m_and_f <- filter(superheo_dat, Gender %in% c("Male","Female"))
superhero_grouped <- group_by(superhero_m_and_f, Gender)
superhero_heights <- summarise(superhero_grouped, ave_height = mean(Height))



# - nested functions
# this is hard to read because we start from the inside and work out
summarise(group_by(filter(superhero_dat, Gender %in% c("Male", "Female")), Gender), ave_height = mean(Height))



# - chain functions together using the pipe operator
superhero_heights <- superhero_dat %>%
  filter(Gender %in% c("Male","Female")) %>%
  group_by(Gender) %>%
  summarise(ave_height = mean(Height))
