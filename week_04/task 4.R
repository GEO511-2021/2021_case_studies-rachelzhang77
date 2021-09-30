install.packages(tidyverse)
install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

str(flights)


##see the structure of two datasets
view(airports)
view(flights)

##join two datasets together in order to get the full name of the airports
join2=left_join(flights,airports,by=c("dest"="faa"))


##keep the only airport that is furthest from the airport
view(join2)
## rearrange the combined dataset by using the furthest distance
farthest_airport=arrange(join2,desc(distance))%>%
  select(name)%>%
slice(1)%>% ##only keep the airport value which is furthest from the nyc airport
  as.character() ##save it as an object

str(farthest_airport)


