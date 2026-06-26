library(ggplot2)
library(dplyr)
library(lubridate)
aqdata <- airquality
aqdata <- mutate(aqdata, unified_date = make_date(year = 1973, month = Month, day = Day))
ggplot() +
  geom_point(size = 1, alpha = 0.8, data = aqdata, aes(y = Ozone, x = unified_date, colour = Temp)) +
  geom_smooth(data = aqdata, aes(y = Ozone, x = unified_date, color = Temp, method = "lm")) + scale_color_gradientn(colours = c("blue", "yellow", "red")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%B", expand = c(0.05, 0)) + labs(title = "New York Air Quality, 1973, May - October", y = "Ozone", x = "Date")
