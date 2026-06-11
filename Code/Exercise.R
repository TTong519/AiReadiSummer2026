library(ggplot2)
library(dplyr)
library(lubridate)
aqdata <- airquality
aqdata <- mutate(aqdata, unified_date = make_date(year = 1973, month = Month, day = Day))
aqdata <- mutate(aqdata, Heat = case_when(Temp >= 85 ~ "High", Temp < 75 ~ "Low", TRUE ~ "Mid"))
ggplot() +
  geom_point(size = 1, alpha = 0.8, data = aqdata, aes(y = Ozone, x = unified_date, colour = Heat)) +
  geom_smooth(data = aqdata, aes(y = Ozone, x = unified_date, colour = Heat, method = "lm")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%B", expand = c(0.05, 0)) + labs(title = "New York Air Quality, 1973, May - October", y = "Ozone", x = "Date")
