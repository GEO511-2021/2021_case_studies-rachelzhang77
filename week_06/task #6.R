install.packages("raster")
install.packages("sp")
install.packages("spData")
install.packages("tidyverse")
install.packages("sf")
install.packages("dplyr")

library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(dplyr)

##download the data
data(world)  #load 'world' data from spData package
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)

###1. Prepare country polygon data (the world object).
# Remove “Antarctica” with filter() because WorldClim does not have data there.
# Convert the world object to sp format (the ‘old’ format) because the raster package doesn’t accept sf objects. you can do this with as(world,"Spatial").

world_filter=world %>% 
  filter(continent!="Antarctica")

as(world_filter,"Spatial")

###2. Prepare Climate Data
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)
plot(tmax_monthly)
head(tmax_monthly)

?gain()
##convert it to degree
# tmax_monthly_c=tmax_monthly/10
gain(tmax_monthly)=0.1

##or gain(tmax_monthly_c)=0.1

##create the annual maximum temperature 
tmax_annual=max(tmax_monthly)

##change the layer names in the new tmax_annual object
names(tmax_annual) <- "tmax"

###3. Calculate the maximum temperature observed in each country.
tmax_country=raster::extract(x=tmax_annual,y=world_filter,fun=max,na.rm=T, small=T, sp=T)
tmax_country_sf=st_as_sf(tmax_country)

head(tmax_country)

###4. 

##make the plot
ggplot(tmax_country_sf) +
 geom_sf(data=tmax_country_sf,aes(fill=tmax))+
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+
  theme(legend.position = 'bottom')

###
hottest_country=tmax_country_sf %>% 
group_by(continent) %>% 
  top_n(tmax,n=1) %>% 
select(name_long,continent,tmax) %>% 
  arrange(desc(tmax)) %>% 
  st_set_geometry(NULL)

hottest_country

