install.packages(tidyverse)
install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

str(flights)

##arrange according to the distance
arrange(.data = flights,... = distance)
slice(.data = flights,... =  distance)

view(airports)
view(flights)
join2=left_join(flights,airports,by=c("dest"="faa"))

view(join2)

select(join2,)
