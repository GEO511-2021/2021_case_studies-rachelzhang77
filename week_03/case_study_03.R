install.packages("gapminder")

library(ggplot2)
library(gapminder)
library(dplyr)

##1
gapminder_=filter(gapminder,country!="Kuwait")
gapminder_

##2 first plot
ggplot(gapminder_,aes(x=lifeExp, y=gdpPercap,color=continent,size=pop/100000))+
  geom_point()+
  facet_wrap(~year,nrow=1)+
  scale_y_continuous(trans = "sqrt")+
  theme_bw()+
  labs(title="Wealth and life expectancy through time",x="Life Expectancy",y="GDP per capita",size="Population(100k)")

gapminder_

ggsave("task 3_1.png",width=15)

##3 
gapminder_continent=gapminder_ %>%
  group_by(continent,year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
            pop = sum(as.numeric(pop)))

gapminder_continent
##4 2nd plot
gapminder
ggplot(gapminder_,aes(x=year, y=gdpPercap, color=continent,size=pop/100000)) + 
  geom_line(aes(group=country,size=0.1)) + 
  geom_point() + 
  geom_line(data=gapminder_continent,aes(x=year,y=gdpPercapweighted),color="black",size=0.5) + 
  geom_point(data=gapminder_continent,aes(x=year,y=gdpPercapweighted),color="black") + 
  facet_wrap(~continent,nrow=1) + 
  theme_bw() + 
  labs(x="Year",y="GDP per capita",size="Population(100k)")

##5
ggsave("task 3_2.png",width=15)




