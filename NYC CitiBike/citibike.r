library(dplyr)
library(readr)
library(ggplot2)
library(ggmap)

jan <- read_csv("~/Desktop/141/citibike/201701-citibike-tripdata.csv")
feb <- read_csv("~/Desktop/141/citibike/201702-citibike-tripdata.csv")
mar <- read_csv("~/Desktop/141/citibike/201703-citibike-tripdata.csv")


jan$wd <- weekdays(jan$`Start Time`)
jan$hour <- strptime(jan$`Start Time`, format = '%Y-%m-%d %H:%M:%S')[[3]]
feb$wd <- weekdays(feb$`Start Time`)
feb$hour <- strptime(feb$`Start Time`, format = '%Y-%m-%d %H:%M:%S')[[3]]
mar$wd <- weekdays(mar$`Start Time`)
mar$hour <- strptime(mar$`Start Time`, format = '%Y-%m-%d %H:%M:%S')[[3]]

mosaicplot(table(jan$hour, jan$wd)[,c(2,6,7,5,1,3,4)], main = "Distribution of Bicycle Use in January 2017", color = rainbow(7), off = F, las = 1)
mosaicplot(table(feb$hour, feb$wd)[,c(2,6,7,5,1,3,4)], main = "Distribution of Bicycle Use in February 2017", color = rainbow(7), off = F, las = 1)
mosaicplot(table(mar$hour, mar$wd)[,c(2,6,7,5,1,3,4)], main = "Distribution of Bicycle Use in March 2017", color = rainbow(7), off = F, las = 1)
