library(readr)
library(wordcloud)
library(ggplot2)
trans <- read_csv("~/Desktop/github/Edmunds/transactions.csv")
wordcloud(trans$color_bought, max.words = 40, random.order=FALSE, rot.per=.2, colors=brewer.pal(8,"Dark2"))

trans$dow <- weekdays(as.Date(trans$date_sold))
trans$dow <- factor(trans$dow, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
ggplot(data = trans, aes(x = dow)) +
  geom_bar(stat = "count") +
  ggtitle("car sold through a week")
