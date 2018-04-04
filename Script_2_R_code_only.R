## ------------------------------------------------------------------------
# Set the working directory to the folder where the data is saved.
setwd("~/Documents/scratch/R_netcdf") # This is the file path to where I have saved my data files on my computer. Your file path will be different. Either use Windows Explorer (Finder on a mac) to find the file path, or use the menu at the top of R studio to set the working directory instead. If you want to use the menu instead of this line of code, at the top of R studio click Session >  Set working directory > Choose directory, and navigate to the folder where the data files are saved.

## ------------------------------------------------------------------------
# Install the "ncdf4" package from the internet. This normally only needs to be done a single time on a computer, and then it is installed forever. 
install.packages("ncdf4")

## ------------------------------------------------------------------------
# Load the "ncdf4" package into R. This needs to be done at the start of every R script that uses the package. 
library("ncdf4")

## ------------------------------------------------------------------------
# Open a connection to the NetCDF file and store this connection in a variable called ncfile. (don't worry about what we mean by a "connection" to the file, this will become clear throughout the examples.)
ncfile <- nc_open('2016722131556EnsembleGPP_MR_1deg.nc')
# Print the header of the NetCDF file (i.e. print the NetCDF file's metadata)
print(ncfile)

## ------------------------------------------------------------------------
# Extract the 'lat' variable in the netcdf file, and store it in a variable called 'lat' in R.
lat=ncvar_get(nc=ncfile, varid='lat')
# Extract the 'lon' variable in the netcdf file, and store it in a variable called 'lon' in R.
lon=ncvar_get(nc=ncfile,varid='lon')
# Extract the 'time' variable in the netcdf file, and store it in a variable called 'time' in R.
time=ncvar_get(nc=ncfile, varid="time")
# Extract the 'gpp' variable in the netcdf file, and store it in a variable called 'gpp' in R.
gpp = ncvar_get(nc=ncfile, varid='gpp')

## ------------------------------------------------------------------------
# Use the length function to see how long each variable is
length(lat)
length(lon)
length(time)
length(gpp)

## ------------------------------------------------------------------------
# Use the head() function to see the first 5 entries of each variable, to help us understand out data. 
head(lat)
head(lon)
head(time)
head(gpp)

## ------------------------------------------------------------------------
# Print the last few values in the gpp variable to see if it is still full of NAs. 
tail(gpp)

## ------------------------------------------------------------------------
# Remove all the NAs, and sum up any numbers that remain. If we get a value of 0, there is no data in the gpp variable and it is all NAs, which probably means we have loaded the file incorrectly. If we get any value above 0 then the gpp variable does have some data in it. If the function returns NA, then we have forgotten to use the na.rm=TRUE function arguemnt. 
sum(gpp, na.rm=TRUE)

## ------------------------------------------------------------------------
# Get the long name attribute for the gpp variable, for plotting later
gpp_name=ncatt_get(ncfile, "gpp", "long_name")
print(gpp_name)
# Get the units of the gpp variable, for plotting later 
gpp_units=ncatt_get(ncfile, "gpp", "units")
print(gpp_units)
# Get the value that corresponds to NA in the gpp variable. 
gpp_fillvalue <- ncatt_get(ncfile,"gpp","_FillValue")
print(gpp_fillvalue)

## ------------------------------------------------------------------------
# Close the NetCDF file connection
nc_close(ncfile)

## ------------------------------------------------------------------------
# replace netCDF _FillValues with NA's
gpp[gpp==gpp_fillvalue$value] = NA

## ------------------------------------------------------------------------
# Find the dimensions of the gpp variable
dim(gpp)

## ------------------------------------------------------------------------
# Extract the first time slice from the gpp variable
first_gpp_slice = gpp[,,1]

## ------------------------------------------------------------------------
# Sanity check the dimensions of our first_gpp_slice. Should be 360 by 180
dim(first_gpp_slice)

## ------------------------------------------------------------------------
# Make a quick plot of the first time slice. 
image(first_gpp_slice)

## ------------------------------------------------------------------------
# The map was upside down, so were we extract the first time slice again, but flip it's y axis as we extract it. This is what the 180:1 is doing. 180 is the greatest number and 1 is the least, therefore we are saying take the last value and put it first and take the second to last value and put it second, etc. It flips the matrix. 
flipped_first_gpp_slice = gpp[,180:1,1]
# Plot our new flipped matrix. 
image(flipped_first_gpp_slice)

## ------------------------------------------------------------------------
# install the fields package, which as the image.plot() function. Uncomment the line below (to "uncomment" just means to delete the '#' symbol at the start of the line) to run it for the first time.
# install.packages("fields")
# Load the fields package with the library() function
library("fields")
# Make a plot of our matrix using the image.plot() function, which adds a colourbar automatically. The first argument is the values to use for the x axis, the second argument is the values for the y axis, and the third argument is the actual data values. 
image.plot(lon, lat, flipped_first_gpp_slice)

## ------------------------------------------------------------------------
# Same as the previous plot code but...
image.plot(lon, lat, flipped_first_gpp_slice)
# ... add a low resolution set of coastlines over the top for context. 
map(database = 'world', lwd=1.5, add = T, col='black')

## ------------------------------------------------------------------------
# Install the RColorBrewer package, to give us access to lots of extra colour paletts. Uncomment and run the line below the first time on a computer. 
# install.packages("RColorBrewer")
# Load the RColorBrewer into R with the library() function. 
library("RColorBrewer")
# The same plot and map commands as before, but with the prewer.pal(10,'RdBu) function, which gives us a Red to Blue color ramp with 10 levels. This is then enclosed with the rev() function, which reverses the order of the red-blue color ramp to give us a blue-red color ramp, which is more normal for Environmental sciences. 
image.plot(lon, lat, flipped_first_gpp_slice, col = rev(brewer.pal(10, "RdBu")))
map(database = 'world', add = T, lwd=1.5)

## ------------------------------------------------------------------------
# The same image.plot() and map() code as before, but with a yellow-green-blue color palette.
image.plot(lon, lat, flipped_first_gpp_slice, col = rev(brewer.pal(9,"YlGnBu")))
map(database = 'world', add = T, lwd=1.5)

## ------------------------------------------------------------------------
# Change the margins of the plot, to stop to padding cutting the ends off our very long title.
par(mar=c(5.1,3,4.1,3))
# Same image.plot() and map() code as last time, but remove x and y labels (with xlab= and ylab=), add a main title (with main=), add a legend lable (with legend.lab=), and adjust the location and padding of the legend label so it is not under the legend text (with legend.line= and legend.mar=)
image.plot(lon, lat, flipped_first_gpp_slice, col = rev(brewer.pal(9,"YlGnBu")), xlab="", ylab="", main=gpp_name$value, legend.lab=gpp_units$value, legend.line=4, legend.mar=7)
map(database = 'world', add = T, lwd=1.5)

## ------------------------------------------------------------------------
# Install the colourblind and black and white printer firneds viridis colour palettes
# install.packages("viridis")
# load the viridis package 
library("viridis")
# Same par(), image.plot() and map() functions as before, but using the viridis colour palette.
par(mar=c(3,3,3,3))
image.plot(lon, lat, flipped_first_gpp_slice, col=viridis(256), xlab="", ylab="", main=gpp_name$value, legend.lab=gpp_units$value, legend.line=4, legend.mar=7)
map(database = 'world', add = T, lwd=1.5)

## ------------------------------------------------------------------------
# Open a png graphcs device to export a plot, and make a plot which is 10 inches by 5 inches, and save at a resolution of 300 dpi.
png("gpp_map.png", width=10, height=5, units = 'in', res = 300)
# Same par(), image.plot() and map() functions as before, but using the plasma color palette from the viridis package.
par(mar=c(3,3,3,3))
image.plot(lon, lat, flipped_first_gpp_slice, col=plasma(256), xlab="", ylab="", main=gpp_name$value, legend.lab=gpp_units$value, legend.line=4, legend.mar=7)
map(database = 'world', add = T, lwd=1.5)
# close the png graphics device to complete exporting the plot. 
dev.off()

## ----echo=FALSE, results='hide'------------------------------------------
# This line of code extracts all R code from this document
knitr::purl("Rmd_script_2_netcdf.Rmd", output="Script_2_R_code_only.R")

