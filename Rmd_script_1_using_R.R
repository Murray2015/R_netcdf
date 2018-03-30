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
# Print the first 5 rows of the second column
faithful[1:5, 1]
# print the first 5 rows of all columns
faithful[1:5, ]

## ------------------------------------------------------------------------
plot(x=faithful$eruptions, y=faithful$waiting)

## ------------------------------------------------------------------------
?str

## ------------------------------------------------------------------------
setwd("~/Documents/scratch/R_netcdf")

## ------------------------------------------------------------------------
knitr::purl("Rmd_script_1_using_R.Rmd")

