q3 <- read.csv("~/desktop/github/metrobike/Q3_2016.csv", header = T)
q4 <- read.csv("~/desktop/github/metrobike/Q4_2016.csv", header = T)
q1 <- read.csv("~/desktop/github/metrobike/Q1_2017.csv", header = T)
stations <- read.csv("~/desktop/metrobike/metro_station_table.csv", header = T)

sum(is.na(q3$end_lat))
sum(is.na(q3$end_lon))

sum(is.na(q4$end_lat))
[1] 487
sum(is.na(q4$end_lon))
[1] 487
## 487 bikes are stolen in Q4 2016 because no location ending record

sum(is.na(q1$end_lat))
[1] 564
sum(is.na(q1$end_lon))
[1] 564
## 564 bikes are stolen in Q4 2016 because no location ending record

addmargins(table(q3$trip_route_category))

   One Way Round Trip        Sum 
     49827       5612      55439 
     
addmargins(table(q4$trip_route_category))

   One Way Round Trip        Sum 
     39172       4030      43202 
## amount of bike share customers descrease from Q3 to Q4, one of potential explanation is people seems like to have a taste about what LA metro bike looks like.

addmargins(table(q1$trip_route_category))

   One Way Round Trip        Sum 
     30643       3143      33786 

prop.table(table(q3$trip_route_category))

   One Way Round Trip 
 0.8987716  0.1012284 
 
prop.table(table(q4$trip_route_category))

   One Way Round Trip 
0.90671728 0.09328272
## percentage of one way customers seems increase, apply the two sample proportion test.

prop.table(table(q1$trip_route_category))

   One Way Round Trip 
 0.9069733  0.0930267 

prop.test(x=c(49827, 39172), n=c(55439, 43202))

	2-sample test for equality of proportions
	with continuity correction

data:  c(49827, 39172) out of c(55439, 43202)
X-squared = 17.291, df = 1, p-value = 3.206e-05
alternative hypothesis: two.sided
95 percent confidence interval:
 -0.01168446 -0.00420686
sample estimates:
   prop 1    prop 2 
0.8987716 0.9067173
## q3 vs q4, result supports that percentage of one way customer did increase, potential explanation is people are laready familiar with various bike stations other than the original one.

addmargins(table(q3$passholder_type))

   Flex Pass Monthly Pass      Walk-up          Sum 
        4431        33216        17792        55439 
	
addmargins(table(q4$passholder_type))

   Flex Pass Monthly Pass Staff Annual      Walk-up       Sum
        2794        27081          382        12945     43202          
## Bike share program provider one more subscription option called "Staff Annual", which is unpublized.
		
addmargins(table(q1$passholder_type))

   Flex Pass Monthly Pass      Walk-up          Sum 
        2292        21007        10487        33786 
## the new subscription option "Staff Annual" was cancelled

prop.test(x=c(17792, 12945), n=c(55439, 43202))

	2-sample test for equality of proportions
	with continuity correction

data:  c(17792, 12945) out of c(55439, 43202)
X-squared = 51.209, df = 1, p-value = 8.303e-13
alternative hypothesis: two.sided
95 percent confidence interval:
 0.01545939 0.02712142
sample estimates:
   prop 1    prop 2 
0.3209293 0.2996389 
## q3 vs q4, percentage of walk-up users did decrease, one potential explanation is customers begin to realize the convenience of riding bike, so they tranfer into pass subscription users.

prop.test(x=c(12945, 10487), n=c(43202, 33786))

	2-sample test for equality of proportions with continuity
	correction

data:  c(12945, 10487) out of c(43202, 33786)
X-squared = 10.309, df = 1, p-value = 0.001324
alternative hypothesis: two.sided
95 percent confidence interval:
 -0.017339549 -0.004172316
sample estimates:
   prop 1    prop 2 
0.2996389 0.3103948

## q4 vs q1, two sample proportion test supports that proportion of walk-up user increase, 
## and amount of bikeshare users is decreasing at the same time, implying bikeshare doesn't become more popular, which is a bad signal for the program.

## here is list of top 10 busy stations for Q3
q3_busy <- q3 %>% group_by(start_station_id) %>% count(start_station_id) %>% arrange(desc(n))
colnames(q3_busy) <- c("Station.ID", "Use.Count")
q3_busy$Station.ID <- as.character(q3_busy$Station.ID)
stations$Station.ID <- as.character(stations$Station.ID)
left_join(q3_busy, stations, by = "Station.ID")[1:10,]
Source: local data frame [10 x 5]

   Station.ID Use.Count                 Station.Name
        <chr>     <int>                       <fctr>
1        3030      2198  Main & 1st                 
2        3069      2128  Broadway & 3rd             
3        3014      2055  Union Station West Portal  
4        3005      1904  Flower & 7th               
5        3031      1888  7th & Spring               
6        3064      1858  Grand & 7th                
7        3042      1807  1st & Central              
8        3067      1640  Main & 6th                 
9        3022      1526  3rd & Santa Fe             
10       3035      1483  Figueroa & 8th  

## here is list of top 10 busy stations for Q4
q4_busy <- q4 %>% group_by(start_station_id) %>% count(start_station_id) %>% arrange(desc(n))
colnames(q4_busy) <- c("Station.ID", "Use.Count")
q4_busy$Station.ID <- as.character(q4_busy$Station.ID)
left_join(q4_busy, stations, by = "Station.ID")[1:10]
Source: local data frame [63 x 10]

   Station.ID Use.Count                 Station.Name
        <chr>     <int>                       <fctr>
1        3005      1729  Flower & 7th               
2        3082      1648  Traction & Rose            
3        3069      1629  Broadway & 3rd             
4        3030      1618  Main & 1st                 
5        3031      1587  7th & Spring               
6        3064      1561  Grand & 7th                
7        3014      1465  Union Station West Portal  
8        3067      1301  Main & 6th                 
9        3022      1280  3rd & Santa Fe             
10       3055      1161  7th & Main

q1_busy <- q1 %>% group_by(start_station_id) %>% count(start_station_id) %>% arrange(desc(n))
colnames(q1_busy) <- c("Station.ID", "Use.Count")
left_join(q1_busy, stations, by = "Station.ID")[1:10,1:3]
# A tibble: 10 × 3
   Station.ID Use.Count                 Station.Name
        <int>     <int>                       <fctr>
1        3082      1460  Traction & Rose            
2        3069      1381  Broadway & 3rd             
3        3005      1250  Flower & 7th               
4        3030      1243  Main & 1st                 
5        3064      1242  Grand & 7th                
6        3031      1154  7th & Spring               
7        3022      1087  3rd & Santa Fe             
8        3042      1066  1st & Central              
9        3014      1051  Union Station West Portal  
10       3068      1002  Grand & 3rd 

## change of top 10 busy station from q3 to q4
q3_busy <- left_join(q3_busy, stations, by = "Station.ID")[1:10,]
q4_busy <- left_join(q4_busy, stations, by = "Station.ID")[1:10,]
q1_busy <- left_join(q1_busy, stations, by = "Station.ID")[1:10,1:3]
data.frame(q3_busy$Station.Name, q4_busy$Station.Name)
           q3_busy.Station.Name         q4_busy.Station.Name
1   Main & 1st                   Flower & 7th               
2   Broadway & 3rd               Traction & Rose            
3   Union Station West Portal    Broadway & 3rd             
4   Flower & 7th                 Main & 1st                 
5   7th & Spring                 7th & Spring               
6   Grand & 7th                  Grand & 7th                
7   1st & Central                Union Station West Portal  
8   Main & 6th                   Main & 6th                 
9   3rd & Santa Fe               3rd & Santa Fe             
10  Figueroa & 8th               7th & Main  

## check out which bike stations are easy to be stolen bicycle in Q4 2016
> sort(table(q4$start_station_id[which(is.na(q4$end_lat)==T)]), decreasing=T)

3062 3082 3064 3005 3069 3006 3031 3038 3042 3037 
  20   20   19   18   18   16   16   15   15   14 
3052 3048 3051 3055 3008 3032 3047 3063 3026 3027 
  14   13   13   13   12   11   11   11   10    9 
3030 3058 3067 3011 3016 3018 3019 3022 3023 3068 
   9    9    9    8    8    8    8    8    8    8 
3007 3014 3029 3046 3076 3034 3036 3049 3066 3074 
   7    7    7    7    7    6    6    6    6    6 
3078 3024 3040  \\N 3028 3033 3035 3056 3059 3060 
   6    5    4    3    3    3    3    3    3    3 
3075 3077 3025 3079 3020 3045 3054 3057 3065 3010 
   3    3    2    2    1    1    1    1    1    0 
3080 3081 4108 
   0    0    0 


sort(table(q1$start_station_id[which(is.na(q1$end_lat)==T)]), decreasing=T)

3062 3082 3022 3064 3069 3031 3042 3063 3014 3048 3047 3005 3006 3007 3049 
  32   29   26   25   25   19   19   18   17   17   16   14   13   13   13 
3058 3030 3051 3055 3068 3067 3037 3035 3038 3066 3075 3008 3023 3052 3065 
  13   12   12   12   12   11   10    9    9    9    9    8    8    8    8 
3074 3027 3034 3040 3077 3000 3016 3025 3036 3057 3076 3078 3011 3018 3019 
   8    7    7    6    6    5    5    5    5    5    5    5    4    4    4 
3024 3026 3029 3032 3046 3054 3079 3020 3028 3056 3060 3009 3033 3045 3080 
   4    4    4    4    3    3    3    2    2    2    2    1    1    1    1

## day of week distribution for Q3 2016
addmargins(table(weekdays(strptime(q3$start_time, format = '%m/%d/%Y %H:%M'))))[c(2,6,7,5,1,3,4,8)]

   Monday   Tuesday Wednesday  Thursday    Friday  Saturday 
     7064      7939      7919      8823      9014      7526 
   Sunday       Sum 
     7154     55439

## day of week distribution for Q4 2016
addmargins(table(weekdays(strptime(q4$start_time, format = '%m/%d/%Y %H:%M'))))[c(2,6,7,5,1,3,4,8)]

   Monday   Tuesday Wednesday  Thursday    Friday  Saturday 
     5852      6362      6569      6412      6251      5973 
   Sunday       Sum 
     5783     43202 

## day of week distribution for Q1 2017
addmargins(table(weekdays(strptime(q1$start_time, format = '%m/%d/%Y %H:%M'))))[c(2,6,7,5,1,3,4,8)]

   Monday   Tuesday Wednesday  Thursday    Friday  Saturday    Sunday 
     4335      4835      5331      5110      4778      5031      4366 
      Sum 
    33786 

## two sample proportion test supports that percentage of bike share customers at weekend did increase from Q3 tp Q4
> prop.test(x=c(7526+7154, 5973+5783), n=c(55439, 43202))

	2-sample test for equality of proportions with
	continuity correction

data:  c(7526 + 7154, 5973 + 5783) out of c(55439, 43202)
X-squared = 6.5973, df = 1, p-value = 0.01021
alternative hypothesis: two.sided
95 percent confidence interval:
 -0.012918969 -0.001724012
sample estimates:
   prop 1    prop 2 
0.2647955 0.2721170 

## proportion of bikeshare program user at weekend doesn't change from Q4 2016 to Q1 2017
prop.test(x=c(5973+5783, 5031+4366), n=c(43202, 33786))

	2-sample test for equality of proportions with continuity
	correction

data:  c(5973 + 5783, 5031 + 4366) out of c(43202, 33786)
X-squared = 3.4133, df = 1, p-value = 0.06467
alternative hypothesis: two.sided
95 percent confidence interval:
 -0.0124015486  0.0003697029
sample estimates:
  prop 1   prop 2 
0.272117 0.278133 

> dtla <- get_map(location = 'Downtown LA', zoom = 14)
> ggmap(dtla) + geom_point(aes(x=start_lon, y=start_lat, size = n), data = q3, alpha = 0.5, color = 'orange')
> ggmap(dtla) + geom_point(aes(x=start_lon, y=start_lat, size = n), data = q4, alpha = 0.5, color = 'blue')
		
> q3$wd <- weekdays(strptime(q3$start_time, format = '%m/%d/%Y %H:%M'))
> q4$wd <- weekdays(strptime(q4$start_time, format = '%m/%d/%Y %H:%M'))
> q3$hour <- strptime(q3$start_time, format = '%m/%d/%Y %H:%M')[[3]]
> q4$hour <- strptime(q4$start_time, format = '%m/%d/%Y %H:%M')[[3]]

## mosaic plot of Q3 and Q4
> mosaicplot(table(q3$hour, q3$wd), main = "Distribution of bicycle use for Q3", color = rainbow(7))
> mosaicplot(table(q4$hour, q4$wd), main = "Distribution of bicycle use for Q3", color = rainbow(7))

## make subset "bat" containing variables "wd", "hour" and "season"
> q3$season <- "3"
> q4$season <- "4"
> dat <- bind_rows(q3[,15:17], q4[,15:17])

## hours distribution by comparing Q3 & Q4
> ggplot(dat, aes(x = hour, fill = season)) +
+ geom_histogram(binwidth = .5, alpha = .5, position = "identity") +
+ ggtitle('hour distribution between Q3 & Q4 (overlap)')

## weekdays distribution by comparing Q3 & Q4
> ggplot(data = dat) +
+ geom_bar(mapping = aes(x = wd, fill = season), position = "dodge") +
+ ggtitle('weekdays distribution between Q3 & Q4 (side by side)')

## save the Downtown LA map
dtla <- get_map(location = 'Downtown LA', zoom = 14)
g <- ggmap(dtla)

## let's get the fluid map for Q3
> fluid_q3 <- data.frame(lat = c(q3$start_lat, q3$end_lat),
+ lon = c(q3$start_lon, q3$end_lon),
+ case = as.character(rep(1:dim(q3)[1], 2)),
+ wd = rep(q3$wd, 2))

> g + 
+   facet_wrap(~ wd, ncol = 2) +
+   geom_point(data = fluid_q3, aes(x = lon, y = lat), color = "black", size = 1) +
+   geom_line(data = fluid_q3, aes(x = lon, y = lat, group = case, color = wd), size = 0.01) +
+   ggtitle('Fluid map for Q3')

> fluid_q4 <- data.frame(lat = c(q4$start_lat, q4$end_lat),
+ lon = c(q4$start_lon, q4$end_lon),
+ case = as.character(rep(1:dim(q4)[1], 2)),
+ wd = rep(q4$wd, 2))

> g + 
+   facet_wrap(~ wd, ncol = 2) +
+   geom_point(data = fluid_q4, aes(x = lon, y = lat), color = "black", size = 1) +
+   geom_line(data = fluid_q4, aes(x = lon, y = lat, group = case, color = wd), size = 0.01) +
+   ggtitle('Fluid map for Q4')

## try to make dicision tree onto Q3 dataset
> q3 <- read.csv("~/desktop/metrobike/Q3_2016.csv", header = T)

> q3$start_wd <- weekdays(strptime(q3$start_time, format = '%m/%d/%Y %H:%M'))
> q3$end_wd <- weekdays(strptime(q3$end_time, format = '%m/%d/%Y %H:%M'))
> q3$start_hour <- strptime(q3$start_time, format = '%m/%d/%Y %H:%M')[[3]]
> q3$end_hour <- strptime(q3$end_time, format = '%m/%d/%Y %H:%M')[[3]]

> q3 <- q3[,-c(1,3,4,6,7,9,10,11)]
> str(q3)
		
> set.seed(1)		
> n <- sort(sample(dim(q3)[1], 0.7*dim(q3)[1]))
> training <- q3[n,]
> testing <- q3[-n,]


