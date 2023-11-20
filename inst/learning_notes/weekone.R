# Agenda =======================================================================
# - Basics of working in R at the command line and RStudio goodies
# - Workspace and working directory
# - RStudio Projects
# - How to get help


# R Basics and Workflow

# Basics of working in R at the command line and RStudio goodies ===============
# - Default panes:
#   - Console
#   - Environment/History (tabbed in upper right)
#   - Files/Plots/Packages/Help (tabbed in lower right)
# FYI: FYI: you can change the default location of the panes
#

## Assignments -----------------------------------------------------------------
# - Interact with the live R process in the console by making an assignment and then inspecting the object we created
x <- 3 * 4 # In my head I hear, e.g., “x gets 12”.
x # Retrieve the value stored in x, notice it in environment
# All R statements where you create objects – “assignments” – have this form:
# objectName <- value
#
#   - Operators (<- and +): https://www.statmethods.net/management/operators.html
# Note of using operators space matters: '< -' vs '<-'
#   - Naming objects:
#     - snake_case: preferred
#     - camelCase: okay, not preferred
#     - use.periods: don't do this!
this_is_a_really_long_name <- 2.5 # too long, naming should be compact and easy to understand
my_value <- 2.5
# - Errors: Let's try to inspect:
myvalue
mvalue
# Computers are very simple minded, you have to provide them with very explicit instructions:
# - typos matter (alot)
# - case matters
# - spacing matters, get better at typing.

## Functions -------------------------------------------------------------------
# A function is a set of statements organized together to perform a specific task. 
# R has a large number of in-built functions and the user can create their own functions.
# Basic structure of a function is:
# functionName(arg1 = val1, arg2 = val2, and so on)
# Think, name what you want it to do (e.g., sum) pass the arguments the function needs to do its job.
# 
# - R function seq which generates regular sequences of numbers
# For example between 1 and 10
seq(1, 10)
# Look at documentation:
?seq # notice the description, arguments, and example.  highlight the use of from, to, and by. Why did the function work?
# The above also demonstrates something about how R resolves function arguments. 
# You can always specify in name = value form. But if you do not, R attempts to resolve by position. 
# So above, it is assumed that we want a sequence from = 1 that goes to = 10.
#  Since we didn’t specify step size, the default value of by in the function definition is used, which ends up being 1 in this case. 
# 
# You can assign the product of functions to objects:
y <- seq(1, 10)

# keep in mind that not all functions need arguments:
data()

# We have been adding objects to our environment (upper right hand corner)
# Print them in the console with a function
ls() #?ls

# Remove junk:
rm(x) 
# Maintaining an environment free of clutter is a must!
# More base R functions: https://stat.ethz.ch/R-manual/R-devel/library/base/html/00Index.html

## Workspace and working directory: "Where am I?" ======================================

# Workspace-----------------------------------------------------------------------------
# Up until now we have not needed to worry about the work that we've done and how to save it.
# One day you will need to quit R, go do something else and return to your analysis later.
# One day you will have multiple analyses going that use R and you want to keep them separate.
# To handle these real life situations, you need to make two decisions:
#     - What about your analysis is “real”, i.e. will you save it as your lasting record of what happened?
#     - Where does your analysis “live”?


# As a beginning R user, it’s OK to consider your workspace “real”. 
# Very soon, I urge you to evolve to the next level, where you consider your saved R scripts as “real”. 
# With the input data and the R code you used, you can reproduce everything.  
# You can reuse the code to conduct similar analyses in new projects.
# 
# Check the backup before closing

# So right now, what happens if I close R? 
q()
# Restart RStudio. In the Console you will see a line like this:
# [Workspace loaded from ~/.RData]

# indicating that your workspace has been restored. 
# Look in the Workspace pane and you’ll see the same objects as before. In the History tab of the same pane, you should also see your command history. You’re back in business.

# Remove this option and restart again.

## Working directory ----------------------------------------------------------------------
 # Any process running on your computer has a notion of its “working directory”. 
# In R, this is where R will look, by default, for files you ask it to load. 
# It also where, by default, any files you write to disk will go.

# What is our?
getwd()

# What is contained in it?
list.files()

# As a beginning R user, it’s OK let your home directory or any other weird directory on your computer be R’s working directory. 
# Very soon, I urge you to evolve to the next level, where you organize your analytical projects into separate directories and, when working on project A, set R’s working directory to the associated directory.

setwd()

# But there’s a better way. A way that also puts you on the path to managing your R work like an expert.

## Projects: https://support.posit.co/hc/en-us/articles/200526207-Using-Projects

# Keeping all the files associated with a project organized together – input data, R scripts, analytical results, figures – is such a wise and common practice that RStudio has built-in support for this via its projects.
# 
# 
# Let’s make one to use for the rest of this workshop/class. Do this: File > New Project…. The directory name you choose here will be the project name.
# 
# Open and close it
# 
# Now check that the “home” directory for your project is the working directory of our current R process:


# Check that the “home” directory of your project is the current working directory:
getwd()

# When ever you refer to a file RStudio will look here...


a <- 2
b <- -3
sig_sq <- 0.5
x <- runif(40)
y <- a + (b * x) + rnorm(40)
avg_x <- mean(x)
write(avg_x, "avg_x.txt")
plot(x, y)
abline(a, b, col = "purple")

dev.print(pdf, "toy_line_plot.pdf") #inspect in file

# Uniform distributions are probability distributions with equally likely outcomes. 

# Normal distribution, also known as the Gaussian distribution, is a probability distribution that is symmetric about the mean,
#   - showing that data near the mean are more frequent in occurrence than data far from the mean.

# Let’s say this is a good start of an analysis and your ready to start preserving the logic and code.
# 
# Open a script > go to history > send code to source
# 
# save code
# 
# Quit RStudio. Inspect the folder associated with your project if you wish. Maybe view the PDF in an external viewer.
# 
# Restart R studio, notice that nothing is in the env. Rerun toy, this is out workflow\
# 
# comment code.

## Goodies:

## Workflow recap:
# - Create an RStudio project for an analytical project (one is fine for this course)
# - Keep inputs there (we’ll soon talk about importing data soon)
# - Keep scripts there; edit them, run them in bits or as a whole from there
# - Keep outputs there (like the PDF written above)

