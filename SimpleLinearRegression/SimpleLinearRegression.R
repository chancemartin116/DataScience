# imports library with graphing tools
library(ggplot2) 

# reads csv file and stores data in data frame
weather <- read.csv("data/weather.csv")

# fits a linear model to given data
model <- lm(temperature ~ days, data=weather)

# creates a scatterplot using given data
ggplot(aes(x=days, y=temperature), data=weather) +
	geom_point(shape=4) + # plots points and changes shape of points
	geom_smooth(method=lm, se=FALSE) + # plots linear best fit without confidence range
	ggtitle("Weather: Temperature vs Days")