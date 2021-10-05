install.packages("spData")
install.packages("sf")
install.packages("tidyverse")
library(spData)
library(sf)
library(tidyverse)
library(units) #this one is optional, but can help with unit conversions.


#load 'world' data from spData package
data(world)  
# load 'states' boundaries from spData package
data(us_states)
# plot(world[1])  #plot if desired
# plot(us_states[1]) #plot if desired

albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
world=st_transform(world,crs = albers)

Canada=world %>%
  filter(name_long=="Canada")
str(Canada)

Canada2=st_buffer(st_geometry(Canada),dist=10000)

###2. us_states object
us_states=st_transform(us_states,crs = albers)
NewYork=us_states %>%
  filter(NAME == "New York")

###3. Create a ‘border’ object)
##intersect both of them together
border=st_intersection(x=Canada2,y=NewYork,crs=albers)

##plot the map
ggplot(border)+
  geom_sf(data=NewYork)+
geom_sf(data=border,fill="red")+
  ggtitle("New York Land Within 10km")

##calc the area
borderarea=st_area(border)%>%

set_units(km^2)


