## ------------------------------------------------------------------------
setwd("~/Documents/scratch/R_netcdf")
library("ncdf4")
ncfile <- nc_open("lpj-guess_agmerra_fullharm_yield_mai_global_annual_1980_2010_C360_T0_W0_N60_A0_1deg.nc4")
print(ncfile)
lat=ncvar_get(ncfile, 'lat')
lon=ncvar_get(ncfile,'lon')
time=ncvar_get(ncfile, "time")
yield = ncvar_get(ncfile, 'yield_mai')
yield_units=ncatt_get(ncfile, "yield_mai", "units")
yield_fillvalue <- ncatt_get(ncfile,"yield_mai","_FillValue")
nc_close(ncfile)
# replace netCDF fill values with NA's
yield[yield==yield_fillvalue$value] <- NA
first_yield_slice = yield[,180:1,1]

## ------------------------------------------------------------------------
image(first_yield_slice)

## ------------------------------------------------------------------------
dim(first_yield_slice)

## ------------------------------------------------------------------------
first_yield_slice = yield[,180:1,2]
image(first_yield_slice)

## ------------------------------------------------------------------------
library("fields")
yield2 = yield[,180:1,2]
yield3 = yield[,180:1,3]
yield_difference = yield3 - yield2
image.plot(yield_difference)

## ------------------------------------------------------------------------
library("RColorBrewer")
image.plot(lon, lat, yield_difference, col=rev(brewer.pal(9,'RdBu')))

## ------------------------------------------------------------------------
# Cheat at centering the colourbar at 0 by making the lowest right hand corner the posative maximum absolute value, and making the square next to it the negative maximum absolute value. Do not do this before taking summary statistics of the data, as we are actually changing the data to make it plot how we want it to. Also do not use with low resolution data, as you may be able to see the values you have changed. 
yield_difference_altered = yield_difference
yield_difference_altered[1,1] = max(abs(yield_difference_altered), na.rm=T)
yield_difference_altered[2,1] = -max(abs(yield_difference_altered), na.rm=T)
image.plot(lon, lat, yield_difference_altered, col=rev(brewer.pal(9,'RdBu')))

## ------------------------------------------------------------------------
mean(yield_difference)

## ------------------------------------------------------------------------
mean(yield_difference, na.rm=T)

## ------------------------------------------------------------------------
median(yield_difference, na.rm=T)
sd(yield_difference, na.rm=T)
max(yield_difference, na.rm=T)
min(yield_difference, na.rm=T)

## ------------------------------------------------------------------------
# Make a temporary slice with the data flipped the right way up. Makes everything less complicated! 
temp_slice = yield[,180:1,2]
tropic_capricorn = 90+23
tropic_cancer = 90-23 
tropics_yield_slice = yield[,tropic_capricorn:tropic_cancer,2]
image(tropics_yield_slice)

## ------------------------------------------------------------------------
polar_south = 90 - 60
polar_north = 90 + 60 
polar_yield_slice = temp_slice[,c(1:polar_south, polar_north:180)]
image(polar_yield_slice)

## ------------------------------------------------------------------------
lat1 = 20
lat2 = 150
polar_yield_slice = temp_slice[lat1:lat2, ]
image(polar_yield_slice)

## ------------------------------------------------------------------------
australia_yield_slice = temp_slice[290:335 , 45:80]
image(australia_yield_slice)

## ------------------------------------------------------------------------
pretend_data1 = c(0,1,2,3,4,5)
pretend_mask1 = c(1,1,NA,1,1,1)
pretend_data1 * pretend_mask1

## ------------------------------------------------------------------------
pretend_data2 = c(0,1,2,3,4,5)
pretend_mask2 = c(NA,NA,NA,1,NA,NA)
pretend_data2 * pretend_mask2

## ------------------------------------------------------------------------
ncfile = nc_open("ESA_forest_9regions_v2_1deg.nc")
print(ncfile)
mask = ncvar_get(ncfile, 'region_mask')
nc_close(ncfile)

## ------------------------------------------------------------------------
image.plot(mask, col=rainbow(9))

## ------------------------------------------------------------------------
# Make a new mask for tropical broadleaved deciduous forest using the ifelse() function. This line of code makes a matrix where tropical broadleaved deciduous forest are set to 1, while the rest of the matrix is set to NA. This matrix is then saved to the variable tropical_broad_dec_mask.
tropical_broad_dec_mask = ifelse(mask == 2,1,NA)
# Select that data by multiplying the data in first_yield_slice by the mask. 
first_yield_slice_tropical_broad = first_yield_slice * tropical_broad_dec_mask
# Make a plot of our subsetted data. 
image(first_yield_slice_tropical_broad)

## ------------------------------------------------------------------------
mean(first_yield_slice_tropical_broad, na.rm = T)

## ------------------------------------------------------------------------
# Make a new mask for tropical broadleaved deciduous forest using the ifelse() function. This line of code makes a matrix where tropical broadleaved deciduous forest are set to 1, while the rest of the matrix is set to NA. This matrix is then saved to the variable tropical_broad_dec_mask.
tropical_broad_ever_mask = ifelse(mask == 1,1,NA)
# Select that data by multiplying the data in first_yield_slice by the mask. 
first_yield_slice_tropical_broad_ever = first_yield_slice * tropical_broad_ever_mask
# Make a plot of our subsetted data. 
image(first_yield_slice_tropical_broad_ever)

## ------------------------------------------------------------------------
time_series_australia = yield[250,60,]
plot(time_series_australia, type='l', xlab="Time step", ylab='Yield')

## ------------------------------------------------------------------------
hist(time_series_australia, col='black', main='', xlab='Yield')

## ------------------------------------------------------------------------
knitr::purl("Rmd_script_3_masking.Rmd")

