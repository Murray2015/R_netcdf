# Reading the NetCDF
library(ncdf4)
ncfile <- nc_open('/home/murray/Downloads/absolute.nc')
lat=ncvar_get(ncfile, 'lat')
lon=ncvar_get(ncfile,'lon')
time=ncvar_get(ncfile, "time")
temperature=ncvar_get(ncfile,'tem')
tempname=ncatt_get(ncfile, "tem", "long_name")
tempunits=ncatt_get(ncfile, "tem", "units")
nc_close(ncfile)


### Plotting the NetCDF
library(RColorBrewer)  # For colors
library(maps)          # For World map
library(tidyverse)    # For ggplot2
library(reshape2)     # For melt 
library(fields)       # For image.plot 


# Method 1 - base graphics 
image(lon, rev(lat), temperature[, , 1], col = rev(brewer.pal(10, "RdBu")), main=paste0(tempname$value, '\n', month.name[1]), xlab="", ylab="")
map(database = 'world', add = T, lwd=2)
## Note getting a legend is tricky! 



# Method 2 - ggplot2 graphics
a = temperature[, , 1]
colnames(a) <- rev(lat)
rownames(a) <- lon
b = melt(a)
names(b) = c("lon", "lat", "temp")
ggplot(data = b, aes(x = lon, y = lat, fill = temp)) + 
  geom_raster(interpolate = TRUE) +
  scale_fill_gradientn(colours = rev(rainbow(7)), na.value = NA) +
  theme_bw() +
  coord_fixed(1.3) + borders()



  


# Method 3 - fields package 
image.plot(lon, rev(lat), temperature[, , 1], col = rev(brewer.pal(10, "RdBu")))
map(database = 'world', add = T, lwd=2)

