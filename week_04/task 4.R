install.packages(tidyverse)
install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

str(flights)

##arrange according to the distance
arrange(.data = flights,... = distance)
slice(.data = flights,... =  distance)

##join two datasets together
view(airports)
view(flights)
join2=left_join(flights,airports,by=c("dest"="faa"))


##keep the only airport that is furthest from the airport
view(join2)
farthest_airport=arrange(join2,desc(distance))%>%
  select(name)%>%
slice(1)%>%
  as.character()


str(farthest_airport)


select(join2,"name")
