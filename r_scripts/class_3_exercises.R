library(tidyverse)

###############  MISSING DATA #################

# get average of numeric vector
mean(c(1,2,3))

# get average, but some data is missing
mean(c(1,2,3,NA))

# override the default handling of NA
mean(c(1,2,3,NA), na.rm = TRUE)


############  MISSING DATA readr ###############

# import our superhero data from our last class
superhero_data <- read_csv("data/heroes_information.csv")





glimpse(superhero_data)

#################   FACTORS   #################

# Let's create a character vector of student birth months
month_dat <- c("Jan", "Aug", "Dec", "Mar", "Jun","Jun")

# Given that months of the year are a fixed and known set of values
# we might want to hsve R treat the data as categorical or as a factor
factor(month_dat)

# Better yet, let's specify the months of the year manually
month_levels <- c("Jan","Feb","Mar",
                  "Apr","May","Jun",
                  "Jul","Aug","Sep",
                  "Oct","Nov","Dec")
month_dat <- factor(month_dat, levels = month_levels)
month_dat

# But what if we made a typo, R converts the unknown value into NA
month_dat_typo <- c("Jan","Aug","Jum")
factor(month_dat_typo, levels = month_levels)

# To get warnings when R does these converions use the parse_factor() funciton from the readr package
parse_factor(month_dat_typo, levels = month_levels)

# check the levels in a factor
levels(parse_factor(month_dat_typo, levels = month_levels))


#################   FORCATS   #################
#            Combine Two Factors              #

# let's assume we conducted a survey in three studies and asked for
# which gender the subjects identified with

# study 1 only had subjects respond with male or female
study_1 <- parse_factor(c("male", "female"))

# study 2 only had subjets response with female or other
study_2 <- parse_factor(c("female", "other"))

# study 3 only had subjects respond with male
study_3 <- parse_factor(c("male"))

# naive approach, use the combine function
# NOTE: R converts it into an integer vector, and it is no longer a factor
c(study_1, study_2, study_3)

# Using the fct_c functionn returns a factor which combines all of the valid levels from each vector
fct_c(study_1, study_2, study_3)

#################   FORCATS   #################
#               Collapse levels               #

# Let's break our ficticious data on birth month into seasons
month_dat_lumped <- fct_collapse(month_dat,
             spring = c("Mar","Apr","May")
             
             
             )
month_dat_lumped

# get counts of each level of our factors
fct_count(month_dat)
fct_count(month_dat_lumped)

#################   FORCATS   #################
#            Lump Together levels             #

# We will use the superhero data we already imported at the beginning of the class today

# Let's start by taking a peak at the counts for each eye color
counts <- fct_count(superhero_data$`Eye color`)
counts %>%
    arrange(desc(n)) %>%
    View

# Try lumping everything so that there are 3 levels + 1 for Others
eye_color_3 <- fct_lump()
fct_count(eye_color_3)

# Try lumping everything together so that each remaining level has at least 5% of the data in each level
eye_color_05 <- fct_lump()
fct_count(eye_color_05)

# Remember, you can always use fct_count() after you lump to ensure that no data was lost
# This code gets the count of each level of eye color and then sums them
sum(fct_count(eye_color_05)$n)


#################   FORCATS   #################
#              Relevel a factor               #

# create a factor to practice on
(temp_factor <- parse_factor(c("A","B","C")))

# move the level "C" to become the first level
fct_relevel(temp_factor,"C")

# move the level "A" to the end
fct_relevel(temp_factor, "A", after = Inf)


#################   FORCATS   #################
#         Reorder a factor using counts       #

# Let's use the superhero data again
eye_color_reordered <- fct_infreq(superhero_data$`Eye color`)

# check that it worked
fct_count(eye_color_reordered)

#################   FORCATS   #################
#         Putting it all together             #

# Let's try putting together what we learned last week with forcats
# Create a subset of only "Male" heroes, then
# mutate `Eye color` by lumping the levels together and leaving the top 4 most eye colors, then
# mutate the new `Eye color` and reorder the levels based on counts

superhero_dat_eye_color <- superhero_data %>%
  filter(Gender == "Male") %>%
  mutate(lumped_eye_color = fct_lump(`Eye color`, n = 4),
         lumped_eye_color = fct_infreq(lumped_eye_color))

# check the levels
levels(superhero_dat_eye_color$lumped_eye_color)

# get the counts of eye colors, then sort them in descending order
# we also created another column to convert to a percent
counts <- fct_count(superhero_data$`Eye color`) %>%
  arrange(desc(n)) %>%
  mutate(perc = n / sum(n))
counts

#################    DPLYR    #################
#             Merging two tables              #

class_list <- tibble(id = c(1,2,3,4), name = c("Peter", "Anna", "Lisa","Tom"))
class_list

class_grades <- tibble(id = c(1,2,3,5), grade = c(95, 54, 34, 66))
class_grades

# use only the rows from the first table, and match data from new columns from the second table


# use only the rows from the second table, and match data from new columns from the first table, then reorder columns using select




# Only keep rows that have a match in both tabes



# merge everything and insert NA where applicable



#################   Base R    #################

# Conditional statements
age <- 0
if(age > 0 & age < 10){
  paste("The age is less than 10: ", age)
} else if(age >= 10 & age <= 18){
  paste("The age is greater than 10 and less than 18: ", age)
} else if(age >= 18){
  paste("The age is greater than 18: ", age)
} else {
  paste("The age is nonsensical: ", age)
}

# Looping
for(i in 1:5) {
  print(1:i)
}

# example from the help documentation
for(n in c(2,5,10,20,50)) {
  x <- stats::rnorm(n)
  cat(n, ": ", sum(x^2), "\n", sep = "")
}

f <- factor(sample(letters[1:5], 10, replace = TRUE))
for(i in unique(f)) print(i)

age <- 10
while(age < 18) {
  print(age)
  age <- age +1
}
