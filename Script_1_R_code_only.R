## ------------------------------------------------------------------------
my_var = 144 # creates a variable called "my_var" and stores the number 144 in it.

## ------------------------------------------------------------------------
# Print the contents of my_var to the screen
my_var

## ------------------------------------------------------------------------
# For example, we can add a number to a variable like this:
my_var + 4

## ------------------------------------------------------------------------
# Subtraction:
my_var - 7.5
# Multiplication 
my_var * 1000
# Division
my_var / 12
# Brackets and longer expressions
((my_var + 4) / 10) + (2*my_var) + (1/4)
# Raising to a power 
my_var^2

## ------------------------------------------------------------------------
# Create a new variable and store the value of Pi in it 
pi_3dp = 3.142
# Create a radius variable and store the radius of some circle in it
radius = 5
# Find the area of this circle
circle_area = pi_3dp * radius^2

## ------------------------------------------------------------------------
# Print the contents of circle_area to the screen
circle_area

## ------------------------------------------------------------------------
# Make a variable containing a string
my_fav_sentence = "climate data is cool"
# Print the contents of the varible
my_fav_sentence 

## ------------------------------------------------------------------------
# Make a vector containing the start of the Fibonacci sequence
fib = c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
# Print the contents of the fib variable to the screen
fib

## ------------------------------------------------------------------------
# Multiply every number inside the fib variable by 2.
fib * 2

## ------------------------------------------------------------------------
# Create a matrix of test data
my_mat = matrix(1:12, nrow=3)
# Print the matrix to the screen
my_mat

## ------------------------------------------------------------------------
# The "data()" function is a special function in R that loads a small practise dataset for you into a variable of the same name as between the quotes (in this case, "faithful"). This is not the normal way to load data into R, so don't worry about it! 
data("faithful")
faithful

## ------------------------------------------------------------------------
# Find the dimensions of the data stored in the faithful variable
dim(faithful)

## ------------------------------------------------------------------------
# Print the structure of the faithful variable to the screen
str(faithful)

## ------------------------------------------------------------------------
# print the whole eruptions column
faithful$eruptions

## ------------------------------------------------------------------------
# Print the fifth row of the first column of the faithful dataset
faithful[5,1]

## ------------------------------------------------------------------------
# Print the first 5 rows of the first column
faithful[1:5, 1]
# Print rows 10 to 41 of the second column
faithful[10:41,2]

## ------------------------------------------------------------------------
# Select all of the second column in the dataset (this is equivalent to faithful$waiting)
faithful[ ,2]

## ------------------------------------------------------------------------
# Make a scatter plot of old faithful eruptions
plot(x=faithful$eruptions, y=faithful$waiting)

## ------------------------------------------------------------------------
# Change plot symbols
plot(x=faithful$eruptions, y=faithful$waiting, pch=17)

## ------------------------------------------------------------------------
# Change the color of the symbols. Don't forget to put quotation marks around "red", as it is a string of characters, and R likes strings of characters to be enclosed with quotation marks. Otherwise R would think red was a variable. 
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red")

## ------------------------------------------------------------------------
# Use extra function arguments in the plot() function to change the axis labels.
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)")

## ------------------------------------------------------------------------
# Use extra function arguemnts for the plot() function to add a title, remove excess white space, and change the limits of the plot. 
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)", main="Old faithful eruption times", xaxs="i", yaxs="i", xlim=c(0,6), ylim=c(0, 120))

## ------------------------------------------------------------------------
# Add a subtle grid to the plot. Note that this whole code chunk must be run at the same time with the Ctrl+Shift+Enter command, rather than running one line at a time with Ctrl+Enter (or Cmd+Enter on a mac), which will cause an error due to the plot already being printed to the screen.
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)", main="Old faithful eruption times", xaxs="i", yaxs="i", xlim=c(0,6), ylim=c(0, 120))
grid()

## ------------------------------------------------------------------------
# Open R's internal documentation on the plot function() - this is useful for when you don't have an internet connection. If you do have an internet connection, the internet is often more useful for R questions than the internal documentation, which is sometimes not very clearly written.
?plot

## ------------------------------------------------------------------------
# Set the working directory, so R can find the data files.
setwd("~/Documents/scratch/R_netcdf") # This is the file path to where I have saved my data files on my computer. YOUR FILE PATH WILL BE DIFFERENT. Either use Windows Explorer (Finder on a mac) to find the file path, or use the menu at the top of R studio to set the working directory instead. If you want to use the menu instead of this line of code, at the top of R studio click Session >  Set working directory > Choose directory, and navigate to the folder where the data files are saved.

## ------------------------------------------------------------------------
# Read in the data
my_data = read.table("global_co2_ann.out")

## ------------------------------------------------------------------------
# Quality check the data loading
dim(my_data)
str(my_data)

## ------------------------------------------------------------------------
# Set the column names in the dataframe stored in the variable called my_data
names(my_data) = c("year", "co2")

## ------------------------------------------------------------------------
# Check that the data names have changed
str(my_data)

## ------------------------------------------------------------------------
# Plot the ASCII time series data. Note the new expression() function, which allows mathematical expressions, superscripts and subscripts to be used in plot labels. 
plot(x=my_data$year, y=my_data$co2, xlab="Year", ylab=expression("Annual CO"[2] * " (ppm)"))

## ------------------------------------------------------------------------
# Change from a scatter graph to a line graph with the type='l' function argument. lwd=2 changes the line width. 
plot(x=my_data$year, y=my_data$co2, xlab="Year", ylab=expression("Annual CO"[2] * ' (ppm)'), type='l', lwd=2, col="darkgreen")

## ------------------------------------------------------------------------
## RUN THIS CODE CHUNK ALL AT THE SAME TIME using Ctrl+Shift+Enter on a PC or Cmd+Shift+Enter on a Mac. 

# Open a plot using the jpeg() function. This gives a plot 5 inches across and 4 inches high with a resolution of 300 dots per inch. This is important because many journals demand plots and figures in a certain dpi! Must run the dev.off() function after the plotting command to complete the plot saving process. 
jpeg(filename="my_first_plot.jpg", width=5, height=4, units='in', res=300)
# Change from a scatter graph to a line graph with the type='l' function argument. lwd=2 changes the line width. 
plot(x=my_data$year, y=my_data$co2, xlab="Year", ylab=expression("Annual CO"[2] * ' (ppm)'), type='l', lwd=2, col="darkgreen")
# Close the graphics device to save the plot with dev.off(). If the plot is saved sucessfullly, "null device 1" should be printed in R, and the plot should appear in your working directory. 
dev.off()

## ----echo=FALSE, results='hide'------------------------------------------
# This line of code extracts all R code from this document
knitr::purl("Rmd_script_1_using_R.Rmd", output="Script_1_R_code_only.R")

