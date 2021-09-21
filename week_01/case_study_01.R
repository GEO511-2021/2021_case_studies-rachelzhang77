data(iris)
?mean
petal_length_mean = mean(iris$Petal.Length)
install.packages(ggplot2)
library(ggplot2)
ggplot(data=iris, aes(Petal.Length))+
  geom_histogram(breaks=seq(0,8,by=.5),
                 col="blue",
                 aes(fill=..count..))+
  
  labs(title="Histogram for Petal Length", x="Petal Length", y="Count")


#new in the class
##install.packages("esquisse")
##library(esquisse)
## esquisse::esquisser()
#this code kind of turns the R into SPSS just using clicking

