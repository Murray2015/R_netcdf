## ------------------------------------------------------------------------
my_var = 144 # creates a variable called "my_var" and stores the number 144 in it.

## ------------------------------------------------------------------------
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
circle_area

## ------------------------------------------------------------------------
# Make a variable containing a string
my_fav_sentence = "climate data is cool"
# Print the contents of the varible
my_fav_sentence 

## ------------------------------------------------------------------------
fib = c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
fib

## ------------------------------------------------------------------------
fib * 2

## ------------------------------------------------------------------------
my_mat = matrix(1:12, nrow=3)
my_mat

## ------------------------------------------------------------------------
# The "data()" function is a special function in R that loads a small practise dataset for you into a variable of the same name as between the quotes (in this case, "faithful"). This is not the normal way to load data into R, so don't worry about it! 
data("faithful")
faithful

## ------------------------------------------------------------------------
# Find the dimensions of the data stored in the faithful variable
dim(faithful)

## ------------------------------------------------------------------------
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
faithful[ ,2]

## ------------------------------------------------------------------------
plot(x=faithful$eruptions, y=faithful$waiting)

## ------------------------------------------------------------------------
# Change plot symbols
plot(x=faithful$eruptions, y=faithful$waiting, pch=17)

## ------------------------------------------------------------------------
# Change the color of the symbols. Don't forget to put quotation marks around "red", as it is a string of characters, and R likes strings of characters to be enclosed with quotation marks. Otherwise R would think red was a variable. 
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red")

## ------------------------------------------------------------------------
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)")

## ------------------------------------------------------------------------
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)", main="Old faithful eruption times", xaxs="i", yaxs="i", xlim=c(0,6), ylim=c(0, 120))

## ------------------------------------------------------------------------
plot(x=faithful$eruptions, y=faithful$waiting, pch=17, col="red", xlab="Eruption time (minutes)", ylab="Time between eruptions (minutes)", main="Old faithful eruption times", xaxs="i", yaxs="i", xlim=c(0,6), ylim=c(0, 120))
grid()

## ------------------------------------------------------------------------
?plot

## ------------------------------------------------------------------------
# Set the working directory, so R can find the data files.
setwd("~/Documents/scratch/R_netcdf")

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
plot(x=my_data$year, y=my_data$co2, xlab="Year", ylab=expression("Annual CO"[2]))

## ------------------------------------------------------------------------
plot(x=my_data$year, y=my_data$co2, xlab="Year", ylab=expression("Annual CO"[2]), type='l', lwd=2, col="lightgreen")

## ------------------------------------------------------------------------
knitr::purl("Rmd_script_1_using_R.Rmd")

