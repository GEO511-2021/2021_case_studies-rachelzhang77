#you can change the read_table to read_csv, if you are using the csv.format.
#Also don't forget to change the link
install.packages("tidyverse")
library(tidyverse)

# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"

temp=read_table(dataurl, 
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))

library(ggplot2)
ggplot(data=temp,aes(x=YEAR,y=JJA))+
  geom_line()+
  #geom_line(ra.nm=TRUE), the ra.nm=TRUE remove the NA without giving any warnings.
  geom_smooth(fill="green",col="orange",span=0.2)+
  #the span command is about changing the width of the trend line
  xlab("Year_")+
  ylab("Mean Temp (C)")+
  ggtitle("Buffalo Temp")
#theme classic ()+theme(plot.title=element_text(size =15))can be used to adjust the front size, 
#(also can use axis.title to adjust the position)
#you can do "mytheme=..." to save your own theme and apply it to other projects.
#scale_x_continuous (breaks=c(seq(1880,2021,10),2021)) gives the scale of y axis

#labs(title="Mean Summer Temperature in Buffalo, NY", x="Year", y="Mean Summer Temperature")

ggsave("task 2.png")

