library(readr)
library(wordcloud)
library(ggplot2)
library(dplyr)

#data preparing
trans <- read_csv("~/Desktop/github/Edmunds/transactions.csv")
shop <- read_csv("~/Desktop/github/Edmunds/shopping.csv")

#draw wordcloud for colour trend of vehicles
wordcloud(trans$color_bought, max.words = 40, random.order=FALSE, rot.per=.2, colors=brewer.pal(8,"Dark2"))

#weekday histogram of vehicle sold
trans$dow <- weekdays(as.Date(trans$date_sold))
trans$dow <- factor(trans$dow, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
ggplot(data = trans, aes(x = dow)) +
  geom_bar(stat = "count") +
  ggtitle("car sold through a week")


shop_duplicate_viewer <- shop[which(duplicated(shop$visitor_key) | duplicated(shop$visitor_key, fromLast = T)), ]
shop_duplicate_viewer_count <- shop_duplicate_viewer %>% group_by(visitor_key) %>% count(visitor_key) %>% arrange(desc(n))
head(shop_duplicate_viewer_count)
# A tibble: 6 × 2
    visitor_key     n
          <dbl> <int>
1 -7.700282e+18  1033
2 -3.394541e+18   930
3  8.300000e+01   821
4 -7.158954e+18   798
5 -6.629086e+18   629
6  5.257474e+18   621

trans_buyer_count <- trans %>% group_by(visitor_key) %>% count(visitor_key) %>% arrange(desc(n))
head(trans_buyer_count)
# A tibble: 6 × 2
    visitor_key     n
          <dbl> <int>
1 -9.037257e+18     7
2 -5.748049e+18     6
3 -5.630991e+18     6
4 -1.889510e+18     6
5  7.633414e+18     6
6 -8.984449e+18     5

df1 <- inner_join(shop_duplicate_viewer_count, trans_buyer_count, "visitor_key")
head(df1)
# A tibble: 6 × 3
    visitor_key   n.x   n.y
          <dbl> <int> <int>
1  8.300000e+01   821     2
2  2.178817e+18   300     1
3  5.223068e+18   286     1
4 -1.215298e+18   261     1
5  6.916420e+18   252     1
6 -8.325605e+18   246     1

fivenum(shop_duplicate_viewer_count$n)
[1]    2    2    3    5 1033
# It seems that most of customer made their decision to purchase without double check online. And we are interested in whether edmunds have affect these customers' decision or not

duplicate_viewer_buyer <- inner_join(shop_duplicate_viewer_count, trans_buyer_count, "visitor_key")
duplicate_viewer_buyer_2 <- duplicate_viewer_buyer[which(duplicate_viewer_buyer$n.x == 2),]
# we filter out the customers who use Edmunds 2 times then make their decision to buy vehivle(s)， “act rashly customers”

duplicate_viewer_buyer_2$model_view <- NA
for (i in 1:dim(duplicate_viewer_buyer_2)[1]){
  duplicate_viewer_buyer_2$model_view[i] <- paste(shop_duplicate_viewer$model_name[which(duplicate_viewer_buyer_2$visitor_key[i] == shop_duplicate_viewer$visitor_key)], collapse = ", ")
}

duplicate_viewer_buyer_2$model_buy <- NA
for (i in 1:dim(duplicate_viewer_buyer_2)[1]){
  duplicate_viewer_buyer_2$model_buy[i] <- paste(trans$model_bought[which(duplicate_viewer_buyer_2$visitor_key[i] == trans$visitor_key)], collapse = ", ")
}

trans$model_bought <- ifelse(is.na(trans$model_bought), "", trans$model_bought)
duplicate_viewer_buyer_2$affect <- 0
ptm <- proc.time()
for (i in 1:dim(duplicate_viewer_buyer_2)[1]){
  n <- which(duplicate_viewer_buyer_2$visitor_key[i] == trans$visitor_key)
  for (j in 1:length(n)){
    if (grepl(trans$model_bought[n[j]], duplicate_viewer_buyer_2$model_view[i], ignore.case = T)) duplicate_viewer_buyer_2$affect[i] <- 1
  }
}

colnames(duplicate_viewer_buyer_2)[2:3] <- c("view","buy")
head(duplicate_viewer_buyer_2)
# A tibble: 6 × 6
    visitor_key  view   buy         model_view   model_buy affect
          <dbl> <int> <int>              <chr>       <chr>  <dbl>
1 -9.221278e+18     2     1       Avalon, RAV4  Highlander      0
2 -9.218915e+18     2     1      -1, SLK-Class    Santa Fe      0
3 -9.218544e+18     2     1     Mazda6, Passat      MAZDA3      0
4 -9.217534e+18     2     2       Prius, Prius Prius, QX60      1
5 -9.216948e+18     2     1   Impreza, Impreza     Impreza      1
6 -9.216668e+18     2     1 2 Series, 2 Series      Cooper      0
  
sum(duplicate_viewer_buyer_2$affect)/dim(duplicate_viewer_buyer_2)[1]
[1] 0.6822232
# It suggests that 68.2% of "act rashly customers"(only view online twice) will be affected by Edmunds.com and bought their vehicle(s) right after checking online.
  

view_less_than_buy <- duplicate_viewer_buyer[which(duplicate_viewer_buyer$n.x<duplicate_viewer_buyer$n.y),]
colnames(view_less_than_buy)[2:3] <- c("View","Buy")
head(view_less_than_buy)
# A tibble: 6 × 3
    visitor_key  View   Buy
          <dbl> <int> <int>
1 -1.889510e+18     5     6
2 -8.175485e+18     3     4
3 -7.737229e+18     3     4
4 -6.748331e+18     3     5
5 -4.023446e+18     3     4
6 -3.902019e+18     3     4
# Here is a list of customers who obtains number of view on Edmunds less than number of vehicle bought


