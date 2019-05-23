library(tidyverse)

# Creating Functions ------------------------------------------------------

## Each function needs a name, arguments, body
## The last staement evaluated is returned as the result

get_mean <- function(num_vec) {
  # calculate the mean of a vector
  sum(num_vec) / length(num_vec)
}

# Try it out!
get_mean(c(23,45,91))

# Creating Better Functions -----------------------------------------------

get_mean <- function(num_vec) {
  # check that num_vec is a numeric vector
  
    
    
  
  # Check that num_vec is not empty
  
    
    
  
  # If there are any NA values, then return NA otherwise compute mean
  
    
    
    
    
  
}

# verify that our function is catching problems
get_mean(c(23,45,91))
get_mean(c(23L,45L,91L))
get_mean(c("23",45,91))
get_mean(c(TRUE))
get_mean(c(23,NA,91))


# ggplot2 -----------------------------------------------------------------
# Building a plot from the ground up!

# import our superhero data
superhero_data <- read_csv("data/heroes_information.csv",
                          na = c("", "NA", "-")) %>%
  mutate_if(is.numeric, .funs = na_if, y = -99) %>%
  rename(Id = X1)

# initialize a plot, what happens?
ggplot(data = superhero_data)

# Now let's tell ggplot how to "map" our data onto our canvas
# How does this change our plot?
ggplot(data = superhero_data, mapping = aes(x = Weight, y = Height))

# Try adding a geom layer of points
# Each new layer appears after the initial ggplot() function,
# also remember that each geom_* layer is a function which can take it's own
# arguments!
ggplot(data = superhero_data, mapping = aes(x = Weight, y = Height)) +
  geom_point()

# Let's try adding two more geom_smooth layer: one with a besting fitting line
ggplot(data = superhero_data, mapping = aes(x = Weight, y = Height)) +
  geom_point()



# What else can we do to improve this plot? Color? Remove outliers?
graph_data <- superhero_data %>%


    ggplot(data = graph_data, mapping = aes(x = Weight, y = Height)) +
    geom_point(color = "black") +
    geom_smooth(method = "lm")
  
  

# ggplot2 Histogram -------------------------------------------------------

# The default settings for geom_hist make it hard to paint a picture of superhero Height by Gender
# - Do we want NA values?
# - What position adjustment can we make
# - Can we add color to make the different Genders "pop" out more?
# - What about changing the number of bins?
graph_data <- graph_data %>%
    

ggplot(graph_data, aes(x = Height)) +
  geom_histogram()

# example of jittering
ggplot(superhero_data, aes(x = Alignment, y = Height)) +
  geom_point()

# ggplot2 Faceting --------------------------------------------------------

# turn this scatterplot into a series of scatterplots using Alginment for the columns and Gender for the rows
# How else can we clean up this plot
ggplot(superhero_data, aes(x = Weight, y = Height)) +
  geom_point() +
  

# reorder levels of Alignment
graph_data <- superhero_data %>%
    mutate(Alignment = fct_relevel(Alignment,"good","neutral","bad"))

ggplot(data = graph_data, aes(x = Weight, y = Height)) +
    geom_point() +
    facet_grid(Alignment~Gender) +
    theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5))


# ggplot2 Labels ----------------------------------------------------------

# One way to add a main title, now try changing the x and y axes labels
ggplot(data = superhero_data, aes(x = Weight,  y = Height)) +
  geom_point() +
  labs(title = "Superhero Heights and Weights")




# ggplot2 Themes ----------------------------------------------------------

ggplot(data = superhero_data, aes(x = Weight,  y = Height)) +
  geom_point() +
  labs(title = "Superhero Heights and Weights",
       x = "Weight (lbs)",
       y = "Height (cms)") + 
  theme(plot.title = element_text(face = "bold", hjust = .5))
                                                                                          

# ggplot2 Saving plots ----------------------------------------------------

# We can save a plot internally using the assignment operator "<-"
superhero_height_weight <- ggplot(superhero_data, aes(x = Weight, y = Height))
superhero_height_weight

# We can add layers to our plot object directly using the "+" operator
superhero_height_weight <- superhero_height_weight +
  geom_point()

# Save the plot externally
# - First create a directory to store your plots
ggsave(filename = "plots/Superhero_Scatterplot.jpeg", plot = superhero_height_weight)



# Let's have some fun creating plots using ggplot2

# Let's try to illustrate variability in Height for superheroes

# remove any heros with missing Height or name
# get a random sample to make our plot more managable
# create a new variable to keep track of which hero has above or below average height
# sort the data by Height
# convert name into a factor using the order of appearance in the data (to retain our sorting of Height)
graph_data <- superhero_data %>%
    filter() %>%
    sample_n() %>%
    mutate() %>%
    arrange() %>%
    mutate() %>%
    select()

ggplot(graph_data, aes(x = name, y = Height_centered)) +
    geom_col(aes(fill = Height_centered)) +
    coord_flip()



# Helpful Hints -----------------------------------------------------------

# check if a particular package is loaded or not from inside a function
if (!"tidyverse" %in% .packages()) stop("You forgot to load the tidyverse.")


# density
superhero_data %>%
  filter(!is.na(Gender), Height < 500) %>%
  ggplot(aes(x = Height, color = Gender, fill = Gender)) +
  geom_density(alpha = .5)

# qqplot
superhero_data %>%
  filter(!is.na(Gender), Height < 500) %>%
  ggplot() +
  geom_qq(aes(sample = Height)) +
  geom_qq_line(aes(sample = Height))