# Setting Up R Packages -------------------------------------------------------

# Before we get started with our analysis, we are going to enlist the help fo R packages.
# A package, sometimes also referred to as a library, is a suitable way to organize your own work and, if you want to, share it with others. Typically, a package will include code (not only R code!), documentation for the package and the functions inside, some tests to check everything works as it should, and data sets.
# They increase the power of R by improving existing base R functionalities, or by adding new ones.
# We will be using a range of packages in this course using the tidyverse, so our learning will be rather opinionated. This means...

# Imagine that you'd like to do some natural language processing of Korean texts, extract weather data from the web, or even estimate a model using machine learning, R packages got you covered! 

### R Packages: Installation

# How do I access additional not packages?
# The official repository, CRAN, makes packages freely available through the internet.
# https://cran.r-project.org/

# We could use attempt to do download them and install them by hand.
# Rather, we use functions to do so.
# The most common way is to use the CRAN repository, then you just need the name of the package and use the command install.packages("package").
# For example, we can install the tidyverse package:
install.packages("tidyverse")
# https://www.tidyverse.org/

# This will take a while....

library(tidyverse)

# Non-CRAN packages

# The CRAN is not the only source for packages. There are other repositories like GH were develpers can post packages.
# We will use the rcahelpr package to access data and bespoke functions in this course.
# First, we need to install the devtools package, which contains a range of functions for installing from non-CRAN repositories.
install.packages("devtools")
# Now load it:
library(devtools)

# Next, we can install the package from GH using:
devtools::install_github("cllghn/rcahelpr")

# You may need updates...

### R Packages: Loading

# After a package is installed, you are ready to use its functionalities. If you just need a sporadic use of a few functions or data inside a package you can access them with the notation packagename::functionname(). 
rcahelpr::ca_crimes_and_clearances

# If you will make more intensive use of the package, then maybe it is worth loading it into memory. The simplest way to do this is with the library() command.
library(rcahelpr)
ca_crimes_and_clearances # view the loaded dataset

# To recap:
# - R packages extend R and give us added functionality.
# - Most packages are access using the install.packages() func from CRAN
# - Packages can be loaded into memory using the library() func
# - Some packages are hosted on other sources like GH, we can access them with devtools



# Data types in R --------------------------------------------------------------
# Restart R

# 1D data: Vectors:
#   Atomic vectors (homogeneous): birds of a feather
#   Lists (heterogeneous): a zoo

# Construct 1D Atomic Vectors
# Can be accomplished using a function! c(): constructor of vectors
vector_lgl <- c(TRUE, FALSE, TRUE) # Logical vectors, with logical values (TRUE and FALSE)
vector_dbl <- c(2.0, 2.1, 1.3) # Doubles vectors, floating point numbers
vector_int <- c(1L, 2L, 3L) # Integers, non fractional
vector_chr <- c("Hello", "world", "!") # Characters, anything (d, ch, sym) inside a ""

# Work with Atomic Vectors
# 1. What are you?
class(vector_lgl)
# 2. How much?
length(vector_dbl)
# 3. What is in it?
# Count the values using a cross tabulation
table(vector_chr)
# Check for unique of each value
unique(vector_int)

# Logical evaluations
vector_int >= 2

# Vector operation
vector_dbl + 10

# Perform a range of math functions on vectors:
max(vector_dbl)
min(vector_dbl)
cor(vector_dbl, vector_dbl)
sum(vector_dbl)
mean(vector_dbl)

# Selecting values inside atomic vectors
# Selecting based on fixed position
vector_lgl[2]
# By range
vector_dbl[1:2]
# By logical evaluation
vector_int[vector_int > 2]
vector_chr[vector_chr == "Hello"]

# Data Frame -------------------------------------------------------------------
# 2D data structure and heterogeneous, all variables (columns) in it must be the same length
my_df <- data.frame(
  vector_lgl,
  vector_dbl,
  vector_chr,
  vector_int
)

# Work with Data Frames
# 1. What are you?
class(my_df)
# 2. How much?
ncol(my_df)
nrow(my_df)
# 3. What is in it?
# Compact view
str(my_df)
# Explore
View(my_df)
# Scan
head(my_df)
tail(my_df, 2)

# Putting Data Frames into Practice --------------------------------------------
library(rcahelpr)

# Print it
ca_crimes_and_clearances

# Info
?ca_crimes_and_clearances
# 1. What are you?
class(ca_crimes_and_clearances)
# 2. How much?
ncol(ca_crimes_and_clearances)
nrow(ca_crimes_and_clearances)
# 3. What is in it?
# Compact view
str(ca_crimes_and_clearances)
# Scan
head(ca_crimes_and_clearances)
tail(ca_crimes_and_clearances)
names(ca_crimes_and_clearances)
# Combine
View(head(ca_crimes_and_clearances))



# Higher level data analyis:
# https://dplyr.tidyverse.org/ && show cheatsheet
# Intro to dplyr
library(tidyverse)
# dplyr is a package for data manipulation, it is built to be fast, highly expressive, and open-minded about how your data is stored


# 1. Identify counties where violent sum is larger than 1000 and in 2019
# 1.1 What is the logic?
# 1.2 Filter function: filter() takes logical expressions and returns the rows for which all are TRUE
# 2. Clean up my data to only return certain interesting columns: "Year",  "County", "NCICCode", "Violent_sum"
# 2.1 Check names
# 2.2. Select function:  to subset the data on variables or columns. 
# 3. Combine them using the pipe operator which remove the nesting of functions (example from above)
ca_crimes_and_clearances %>% # and then
  head() %>%
  View()
# 4. Add a summary
# 5. Add a graph
ca_crimes_and_clearances %>% 
  filter(Violent_sum > 1000 & Year == 2019) %>%
  select(Year,  County, NCICCode, Violent_sum) %>%
  ggplot() + geom_bar(aes(x = NCICCode, y = Violent_sum), stat = "identity") + coord_flip()


# 1. Subset the data frame to only include year, county, nciccode, violent sum
# Select columns
# 1.1 What are the variables called: "Year",  "County", "NCICCode", "Violent_sum"
names(rcahelpr::ca_crimes_and_clearances_with_arson)
# 1.2 Subset columns: data.frame[, what_you_want_to_select]
head(rcahelpr::ca_crimes_and_clearances_with_arson[, c("Year",  "County", "NCICCode", "Violent_sum")])

# 2. Filter the data frame to only include rows where the violent_sum is larger than 1000 for the year 2019
# data.frame[what_you_want_to_select, ]
# 2.1 Set up logical evaluations
# violent_sum > 1000 
rcahelpr::ca_crimes_and_clearances_with_arson$Violent_sum > 1000
# year == 2019
rcahelpr::ca_crimes_and_clearances_with_arson$Year == 2019
# 2.2 Filter rows using the logic 
head(rcahelpr::ca_crimes_and_clearances_with_arson[rcahelpr::ca_crimes_and_clearances_with_arson$Violent_sum > 1000 & rcahelpr::ca_crimes_and_clearances_with_arson$Year == 2019, ])

# 3. Combine tasks 1 and 2
out <- rcahelpr::ca_crimes_and_clearances_with_arson[rcahelpr::ca_crimes_and_clearances_with_arson$Violent_sum > 1000 & rcahelpr::ca_crimes_and_clearances_with_arson$Year == 2019,
                                                     c("Year",  "County", "NCICCode", "Violent_sum")]

# 4. Summarize
summary(out)



################################################################################


### Data Types in R

# Before we jump into data frames, we got to do a little table setting and learn about vectors
# These are one-dimensional structures, think of a line a values in the same axis, that come in two flavors:
#   - Atomic vectors: Homogeneous, birds of a feather, a flamboyancy of flamingos
#   - Lists: Heterogeneous, a aviary <- we may talk about these later

# How do we create an atomic vector, with a function! c(). 
# Let's use this function to generate vectors of different classes of things.
vector_lgl   <- c(TRUE, FALSE, TRUE)
vector_dbl    <- c(0x1, 2.0 , 3e0) # Floating point numbers
vector_int   <- c(1L, 2L, 1:3L) # Non fractional
vector_chr <- c("Hello", "world", "!") # Anything between " or '

# Atomic vectors allow us to construct sequences of values for use in our analysis. 
# They are the foundation of the tables that we will use in R.
# When you have a vector, you can interrogate it to learn what is within it and how to use those values:
?class
class(vector_lgl)
typeof(vector_lgl)

# way to interrogate a vector are by functions like:
# Lenghts
length(vector_dbl)
# Sort
sort(vector_dbl)
# See counts of values
table(vector_lgl)
# See unique
unique(vector_lgl)
unique(vector_int)

# Use operators to evaluate items in a vector
vector_int > 2
vector_int + 10

# Selecting Vector Elements: We can grab values within vectors.
# By position
vector_lgl[1]
vector_lgl[2]
# By range
vector_lgl[1:2]
# By value
vector_int[vector_int > 2]
vector_chr[vector_chr != "Hello"]

# Or even perform basic math on vectors
log(vector_dbl)
max(vector_dbl)
min(vector_dbl)
cor(vector_dbl, vector_dbl)
sum(vector_dbl)
mean(vector_dbl)
media(vector_dbl)
quantile(vector_dbl)

### Data Frames

# What are data frames: two-dimensional data structures where each column is an atomic vector of the same length:
# Construct one using the data.frame function
my_df <- data.frame(vector_lgl,
                    vector_dbl,
                    vector_chr)
my_df

# Like with vectors, we can access data, here in columns
my_df$vector_lgl
my_df[ , 1] # or my_df[ ,"vector_dbl"]
my_df[2 ,]

# Or examine type of data structure:
class(my_df)

# examine its dimensions:
nrow(my_df)
ncol(my_df)


# In the prior video we installed gapminder which includes a table of  life expectancy, GDP per capita, and population, every five years, from 1952 to 2007 for countries.
library(rcahelpr)

## data
rcahelpr::ca_crimes_and_clearances

### Exploring Data Frames

# What are you?
class(gapminder)

# Compactly display the structure of data
str(gapminder)

# More ways to query data:
names(gapminder)
nrow(gapminder)
ncol(gapminder)
length(gapminder)

# Scan it
head(gapminder)
tail(gapminder)

# Statistical overview:
summary(gapminder)
summary(gapminder$lifeExp)
summary(gapminder$country)

# Early visualization:
plot(lifeExp ~ year, gapminder)
plot(lifeExp ~ gdpPercap, gapminder)
plot(lifeExp ~ log(gdpPercap), gapminder)

## Introduction to dplyr -------------------------------------------------------

### What is dplyr

### Single Table dplyr Functions

## Introduction to readr -------------------------------------------------------

### Introduction to readr

### Reading with readr and a manipulating with dplyr