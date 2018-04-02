## ------------------------------------------------------------------------
## Use the workflow from R notebook 2 to read in the NetCDF file 
# Set the working directory to where the data files are saved
setwd("~/Documents/scratch/R_netcdf")
# Load the ncdf4 library into R. (note, we installed this with install.packages() in Notebook 2)
library("ncdf4")
# Open a file connection to the NetCDF file
ncfile <- nc_open("lpj-guess_agmerra_fullharm_yield_mai_global_annual_1980_2010_C360_T0_W0_N60_A0_1deg.nc4")
# Print the NetCDFs header
print(ncfile)
# Extract variables from the NetCDF file
lat=ncvar_get(ncfile, 'lat')
lon=ncvar_get(ncfile,'lon')
time=ncvar_get(ncfile, "time")
yield = ncvar_get(ncfile, 'yield_mai')
# Extract attributes from the NetCDF file
yield_units=ncatt_get(ncfile, "yield_mai", "units")
yield_fillvalue <- ncatt_get(ncfile,"yield_mai","_FillValue")
# Close the NetCDF file connection
nc_close(ncfile)
# replace netCDF fill values with NA's
yield[yield==yield_fillvalue$value] <- NA
# Extract the first time slice from the NetCDF file as a matrix, and store in a variable called first_yield_slice. 
first_yield_slice = yield[,180:1,1]

## ------------------------------------------------------------------------
# Make a quick plot of the first time slice 
image(first_yield_slice)

## ------------------------------------------------------------------------
# The last plot seemed to have no data, so to trouble shoot, lets check the matrix of data in first_yield_slice has the dimensions we expect with the dim() function
dim(first_yield_slice)

## ------------------------------------------------------------------------
# The dimensions seemed fine, so to continue to troubleshoot let's trying selecting a different time slice. Maybe it's just the first time slice that is empty. 
first_yield_slice = yield[,180:1,2]
image(first_yield_slice)

## ------------------------------------------------------------------------
# Let's make a difference map by subtracting one time slice from another. 
# Load the fields package for plots with a colourbar. We installed the fields package with install.packages() in Notebook 2.
library("fields")
# Select the second time slice and store in a variable called yield2. Note the 180:1 in the lattitude space, which flips the matrix (as it is upside down in the yield variable)
yield2 = yield[,180:1,2]
# # Select the third time slice and store in a variable called yield3. Note the 180:1 in the lattitude space, which flips the matrix (as it is upside down in the yield variable)
yield3 = yield[,180:1,3]
# Find the difference between the two matrixs of data. 
yield_difference = yield3 - yield2
# Make a plot of the difference
image.plot(yield_difference)

## ------------------------------------------------------------------------
# Load the RColorBrewer library (which we installed in Notebook 2 with the install.packages() function) to give us more colour ramps.
library("RColorBrewer")
# Remake the difference map with a polar colour pallete (i.e. cold to hot colours) with 9 levels. Note the rev() function used to reverse the colour pallete, as by default it goes from red to blue not blue to red. 
image.plot(lon, lat, yield_difference, col=rev(brewer.pal(9,'RdBu')))

## ------------------------------------------------------------------------
# Cheat at centering the colourbar at 0 by making the lowest right hand corner the posative maximum absolute value, and making the square next to it the negative maximum absolute value. Do not do this before taking summary statistics of the data, as we are actually changing the data to make it plot how we want it to. Also do not use with low resolution data, as you may be able to see the values you have changed. 
yield_difference_altered = yield_difference
yield_difference_altered[1,1] = max(abs(yield_difference_altered), na.rm=T)
yield_difference_altered[2,1] = -max(abs(yield_difference_altered), na.rm=T)
image.plot(lon, lat, yield_difference_altered, col=rev(brewer.pal(9,'RdBu')))

## ------------------------------------------------------------------------
# Find the mean of our difference between slices 2 and 3. 
mean(yield_difference)

## ------------------------------------------------------------------------
# Find the difference between slices 2 and 3, removing NAs before. 
mean(yield_difference, na.rm=T)

## ------------------------------------------------------------------------
# Find other summary statistics for the difference between slices 2 and 3. 
median(yield_difference, na.rm=T)
sd(yield_difference, na.rm=T)
max(yield_difference, na.rm=T)
min(yield_difference, na.rm=T)

## ------------------------------------------------------------------------
# Make a temporary slice with the data flipped the right way up. Makes everything less complicated! 
temp_slice = yield[,180:1,2]
# The tropic of Capricorn is at 23 degrees north. However remember our matrix starts at 0 at the bottom corner and goes up to 180 at the top corner, rather than the usual -90 degrees of the south pole and +90 degrees at the north pole. So we need to do 90 + 23 to find the tropic of capricorn on our grid. 
tropic_capricorn = 90+23
# Similar to the tropic of Capricorn above, the tropic of cancer is at is at 23 degrees south. However our matrix starts at 0 at the bottom corner and goes up to 180 at the top corner, rather than the usual -90 degrees of the south pole and +90 degrees at the north pole. So we need to do 90 - 23 to find the tropic of cancer on our grid. 
tropic_cancer = 90-23 
# Subset our grid with the square bracket notation. leave the first space blank to select all of the lonitudes. The use the colon notation to select the range of values between the tropic of Cancer and the tropic of Capricorn. 
tropics_yield_slice = temp_slice[ , tropic_cancer:tropic_capricorn]
# Make a quick plot of our subsetted data. It will obviously look distorted as it is being streched by the image function. There are several ways to make a correctly scaled map for a subset, but that is outside of the scope of this R notebook. 
image(tropics_yield_slice)

## ------------------------------------------------------------------------
# The polar regions are regions above 60 degrees north and below 60 degrees south lattitude. However remember our grid goes from 0 to 180 at the sides, not from -90 to +90. Therefore to get the correct locations we do 90-[lattitude of interest] and 90+[lattitude of interest]
polar_south = 90 - 60
polar_north = 90 + 60 
# use the square bracket notation to subset our grid of data. Leave the first space before the comma blank to select all longitudes. The second space is a little complex. We use 1:polar_south to get the south polar region, and polar_north:180 to get the north polar region. We then use the concatenate function "c()" to stick the two blocks of data together to allow subsetting. This is a little complex I realize, but just copy and paste this code if you need it. 
polar_yield_slice = temp_slice[ , c(1:polar_south, polar_north:180) ]
# Make a quick plot of the data. Note it will look weird because Antarctica and lots of Arctica Canada and Greenland don't appear to have been modelled. However you can see the top of Norway and parts of Russia. 
image(polar_yield_slice)

## ------------------------------------------------------------------------
# The longitude bounds for north and south America are roughly 160 degrees west to 30 degrees west. However remember our matrix goes from 0 at the left hand side to 360 at the right hand side, rather than the more familliear -180 to +180. Therefore we need to do 180-160 for 160 degrees west and 180-30 for 30 degrees west.
lat1 = 180 - 160
lat2 = 180 - 30
# Select the longitude slide using the lat1:lat2 colon notation to select the range of values. Leave the space after the comma blank to select all values for lattitude. 
polar_yield_slice = temp_slice[lat1:lat2, ]
# Make a quick plot of the lattitude slice.
image(polar_yield_slice)

## ------------------------------------------------------------------------
# Subset both lattitude and longitude to find australia. Here I just played with values to find the correct bounds for Australia, rather than the method above. 
australia_yield_slice = temp_slice[290:335 , 45:80]
# Make a quick plot of the data.
image(australia_yield_slice)

## ------------------------------------------------------------------------
# Demonstrating the idea of how to subset data in R using a mask. We want to have a mask filled with NAs where we want to not have data, and 1s where we do have data.
pretend_data1 = c(0,1,2,3,4,5)
pretend_mask1 = c(1,1,NA,1,1,1)
# When we multiple our mask and our data, the data will stay the same where it is being multiplied by 1, but will change to NA where it is multiplied by NA. This example demonstrates masking out just one value. 
pretend_data1 * pretend_mask1

## ------------------------------------------------------------------------
# Demonstrating the idea of how to subset data in R using a mask. We want to have a mask filled with NAs where we want to not have data, and 1s where we do have data.
pretend_data2 = c(0,1,2,3,4,5)
pretend_mask2 = c(NA,NA,NA,1,NA,NA)
# When we multiple our mask and our data, the data will stay the same where it is being multiplied by 1, but will change to NA where it is multiplied by NA. This example demonstrates masking out all except one value.
pretend_data2 * pretend_mask2

## ------------------------------------------------------------------------
# Read in a NetCDF file containing a mask for forest regions around the world. Here we use the same NetCDF workflow as shown in Notebook 2, but much reduced. 
# Open a file connection to the NetCDF containing the mask values
ncfile = nc_open("ESA_forest_9regions_v2_1deg.nc")
# Print the header information for the NetCDF file
print(ncfile)
# Use the ncvar_get() function to get the values of the mask
mask = ncvar_get(ncfile, 'region_mask')
# Close the connection to the NetCDF file.
nc_close(ncfile)

## ------------------------------------------------------------------------
# Make a quick plot of the values in the mask file 
image.plot(mask, col=rainbow(9))

## ------------------------------------------------------------------------
# After plotting the mask, we see that the format of the mask is numbers from 1 to 9, rather than the 1s and NAs that we want. Here we make a new mask for tropical broadleaved deciduous forest using the ifelse() function. This line of code makes a matrix where tropical broadleaved deciduous forest are set to 1, while the rest of the matrix is set to NA. This matrix is then saved to the variable tropical_broad_dec_mask.
tropical_broad_dec_mask = ifelse(mask == 2,1,NA)
# Select that data by multiplying the data in first_yield_slice by the mask. 
first_yield_slice_tropical_broad = first_yield_slice * tropical_broad_dec_mask
# Make a plot of our subsetted data. 
image(first_yield_slice_tropical_broad)

## ------------------------------------------------------------------------
# Get a summary statistic for the yield of the tropical broadleaf forests
mean(first_yield_slice_tropical_broad, na.rm = T)

## ------------------------------------------------------------------------
# Make a new mask for tropical broadleaved deciduous forest using the ifelse() function. This line of code makes a matrix where tropical broadleaved deciduous forest are set to 1, while the rest of the matrix is set to NA. This matrix is then saved to the variable tropical_broad_dec_mask.
tropical_broad_ever_mask = ifelse(mask == 1,1,NA)
# Select that data by multiplying the data in first_yield_slice by the mask. 
first_yield_slice_tropical_broad_ever = first_yield_slice * tropical_broad_ever_mask
# Make a plot of our subsetted data. 
image(first_yield_slice_tropical_broad_ever)

## ------------------------------------------------------------------------
# Here we extract a time series from the yield data by specifying a single lattitude and longitude, but then leave the third space inside the square brackets blank to select all time slices at that lat/long location. 
time_series_australia = yield[250,60,]
# Plot the time series we have just extracted. 
plot(time_series_australia, type='l', xlab="Time step", ylab='Yield')

## ------------------------------------------------------------------------
# Finally, make a histogram of our time series data. Just because we can. 
hist(time_series_australia, col='black', main='', xlab='Yield')

## ------------------------------------------------------------------------
knitr::purl("Rmd_script_3_masking.Rmd")

