---
title: "Project Proposal"
output: github_document
author: Rachel Zhang
---

Project Proposal
# Introduction to problem/question
The surgent growth of gentrification across U.S. cities since the 1970s has received increasing attention from American society. Gentrification has significantly changed — for better or worse — the socioeconomic neighborhood characteristics. This city redevelopment trend has nearly coincided with the U.S. city crime changes in the late 20th century — the crime rates in major U.S. cities increased from the 1960s to 1980s, and they experienced a considerable drop during the 1990s (Barton 2016). Scholars have spent limited resources in studying the relationship between gentrification and crime, while considering the widespread spatial phenomenon and the growing importance of crime occurrences in the United States, it is essential to explore the potential association between these two general trends.

# Problem / Question
Is there a correlation between crime and different degrees of gentrification at the tract level in Buffalo, New York?

# Inspiring Examples
## Example 1 
![Crime data]( https://data.buffalony.gov/Public-Safety/Crime-Incidents-Data-Lens-/vhp3-62vz )
With the crime data from 2009 to 2021, these several crime incidents maps on the buffalo government are interactive and accessible for people to have a basic understanding of the crime incidents in the areas they live or are interested in. I think this kind of map with pop-ups can be made with the leaflet package in R. This also is the data source of the crime data in my own project. 


## Example 2
 
![Gentrification and crime](https://i.guim.co.uk/img/media/879160b6cfafa7755c2f12300d2d08a95fd9f7d8/463_0_1643_986/master/1643.jpg?width=1020&quality=45&auto=format&fit=max&dpr=2&s=6d516152e0fe763b04bfb8f19f4ccf59)

This map includes the different types of data that I am interested in — gentrification levels and crime data at the tract level. However, I found this map to be a little bit confusing, because it presents the gentrification levels and crime levels in the same way (fill by colors), and it can be hard for readers to distinguish the meanings of the two kinds of color scales or visually identify the relationship between these two variables. It might be better if I can present the crime level data with simple arrows, and the gentrification level data can be presented in the different scales of color in the tract (can do these steps in geom_sf (aes(fill=…)) and geom_segment())

## Example 3

 
![crime map](https://bookdown.org/fis/social-life-of-neighborhoods/images/crime_heat_map.gif)
Alternatively, this kind of crime map can also be used in my project. Crime incidents can be represented as points in the map, and by creating the heat map, the incidents can be identified more easily. Multiple incidents that happen in the same tract can be specified in the pop-up boxes by using addCircleMarkers(popup= ~paste0(crime type, incident_date, …) in the leaflet package.

# Proposed data sources
Buffalo crime records at the census tract level from 2011-2019 will be geocoded according to the longitude and latitude in the Open Data Buffalo database.
The Buffalo census tract data from 2011 to 2019 used for measuring gentrification will be retrieved from the “tidycensus” package in R.

# Proposed methods

1.	I am going to use the tidycensus package to get the data for measuring the degree of gentrification from 2011 to 2019 acs. I will select and calculate the variables that I need to measure gentrification according to the gentrification index (Appendix A). Writing a loop to create a data list for each year at both tract and county levels. I manually add the education variables in the 2011 and 2010 data from the social explorer website since the tidycensus doesn’t have the variable that I need in these two years.
2.	Creating a gentrification_degree df: I am going to assign a gentrification degree to each census tract (No gentrification-related changes, susceptible to gentrification, middle stage, late stage, ongoing gentrification, gentrified) (in Appendix B). 
3.	Merge with the crime data (gentri_crime df): download the crime data from the data.buffalony.gov in the csv. format, and use the merge() function to merge the crime data with the spatial census data.
4.	Creating the gentrification degree map (code maybe like this):
Gentrification_df %>%
group_by(Year) 
ggplot(gentri_crime, aes(fill=gentrification_degree))+
geom_sf()+
scale_fill_viridis_c()
5.	Adding crime data on the map: Using leaflet(gentri_crime) %>% addProviderTiles(“CartoDB”(maybe?)) %>% addCircleMarkers(label=~paste0(tract_names, …), radius=…, color=~pal(…)) to point out the crime data.
crime[,c("x","y")]=st_coordinates(st_centroid(crime))?
6.	Use GGally package to build correlograms, and the ggplot2 package to color and split the year group.
Corr: ggcorr(gentri_crime, method = c("everything", "pearson"))
#Can I make dynamic maps among different years?

# Expected results

In the map that I am going to make, I expect the crime rate will be lower in most tracts with higher levels of gentrification, but certain types of crime (e.g., property crimes) may have a higher rate in relatively late-gentrifying or gentrified tracts.

![Appendix A Table 1. Gentrification Measurement](/Users/rachelzhang/Desktop/GEO 511/2021_case_studies-rachelzhang77/Project/Table 1.png)

![Appendix A Table 2. Neighborhood Typologies Definitions](/Users/rachelzhang/Desktop/GEO 511/2021_case_studies-rachelzhang77/Project/Table 2.png)
