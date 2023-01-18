####Google Data Analytics Capstone###
Case Studi : Cycliatic Bike-Share

#This is steps for prepare and process the data with R studio before analyzing with Tableau 

#1. Install the pacakges and load them all 
install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("geosphere")

library(ggplot2)
library(tibble)
library(dplyr)
library(readr)
library(purrr)
library(tidyr)
library(stringr)
library(forcats)
library(lubridate)
library(geosphere)

#2. Import data and merge all the data. 

#i am not use all of data because my laptop can not load them 

desember21 = read.csv("~/Bicycle/202112-divvy-tripdata.csv")
desember21 = desember21[c(1:12475),]
januari22 = read.csv("~/Bicycle/202201-divvy-tripdata.csv")
januari22 = januari22[c(1:10377),]
februari22 = read.csv("~/Bicycle/202202-divvy-tripdata.csv")
februari22 = februari22[c(1:11561),]
maret22 = read.csv("~/Bicycle/202203-divvy-tripdata.csv")
maret22 = maret22[c(1:12841),]
april22 = read.csv("~/Bicycle/202204-divvy-tripdata.csv")
april22 = april22[c(1:13713),]
mei22 = read.csv("~/Bicycle/202205-divvy-tripdata.csv")
mei22 = mei22[c(1:16349),]
juni22 = read.csv("~/Bicycle/202206-divvy-tripdata.csv")
juni22 = juni22[c(1:17693),]
juli22 = read.csv("~/Bicycle/202207-divvy-tripdata.csv")
juli22 = juli22[c(1:18235),]
agustus22 = read.csv("~/Bicycle/202208-divvy-tripdata.csv")
agustus22 = agustus22[c(1:17860),]
september22 = read.csv("~/Bicycle/202209-divvy-publictripdata.csv")
september22 = september22[c(1:17014),]
oktober22 = read.csv("~/Bicycle/202210-divvy-tripdata.csv")
oktober22 = oktober22[c(1:15586),]
november22 = read.csv("~/Bicycle/202211-divvy-tripdata.csv")
november22 = november22[c(1:13378),]

#make the data into one location, name :   
bicycle_trip = bind_rows(desember21, januari22, februari22, maret22, april22, 
                         mei22, juni22, juli22, agustus22, 
                         september22, oktober22, november22, ) 

#3. Clean the missing / N.A 

#before clean the missing data, check how much rows and columns use glimpse() and summary use summary()

glimpse(bicycle_trip)

summary(bicycle_trip)

#make a new data frame from data that has been clean

clean_bicycle_trip= drop_na(bicycle_trip)


#4. Add some columns for analysis purposes  

clean_bicycle_trip$date <- as.Date(clean_bicycle_trip$started_at)

clean_bicycle_trip$month <- format(as.Date(clean_bicycle_trip$date), "%m")

clean_bicycle_trip$day <- format(as.Date(clean_bicycle_trip$date), "%d")

clean_bicycle_trip$year <- format(as.Date(clean_bicycle_trip$date), "%Y")

clean_bicycle_trip$start_time = strftime(clean_bicycle_trip$ended_at, "%H")

clean_bicycle_trip$day_of_week <- format(as.Date(clean_bicycle_trip$date), "%A")

clean_bicycle_trip$ride_length = difftime(clean_bicycle_trip$ended_at,clean_bicycle_trip$started_at) 

clean_bicycle_trip$ride_distance <- distGeo(matrix(c(clean_bicycle_trip$start_lng , 
                                                     clean_bicycle_trip$start_lat), ncol = 2), 
                                            matrix(c(clean_bicycle_trip$end_lng, 
                                             clean_bicycle_trip$end_lat), ncol = 2)) 

clean_bicycle_trip$ride_distance <- clean_bicycle_trip$ride_distance/1000



clean_bicycle_trip$ride_length <- as.numeric(clean_bicycle_trip$ride_length)

#check how much columns, rows and summary after data has been clean and adds some columns 

glimpse(clean_bicycle_trip)

summary(clean_bicycle_trip)

#5. The next step is save the data to computer and the data is ready to be used for analyze use Tableau 
write.csv(clean_bicycle_trip,"clean_bicycle_trip.csv", row.names = FALSE) 



#Note : i got the data from a bike-sharing company : https://divvy-tripdata.s3.amazonaws.com/index.html
 