library(ggplot2)
library(dplyr)
library(lubridate)
aqdata <- airquality %>%
  mutate(
    unified_date = make_date(year = 1973, month = Month, day = Day),
    num_date = as.numeric(unified_date)
  ) %>%
  filter(!is.na(Ozone) & !is.na(Temp) & !is.na(unified_date))
grid_seq <- data.frame(
  unified_date = seq(min(aqdata$unified_date), max(aqdata$unified_date), length.out = 100000)
) %>%
  mutate(num_date = as.numeric(unified_date))
model_ozone_loess <- loess(Ozone ~ num_date, data = aqdata, span = 0.75)
model_temp_loess  <- loess(Temp ~ num_date, data = aqdata, span = 0.75)
predicted_data_loess <- grid_seq %>%
  mutate(
    Ozone = predict(model_ozone_loess, newdata = grid_seq),
    Temp = predict(model_temp_loess, newdata = grid_seq)
  )
ggplot() +
  geom_point(data = aqdata, aes(x = unified_date, y = Ozone, color = Temp), 
             size = 1, alpha = 1.0) +
  geom_point(data = predicted_data_loess, aes(x = unified_date, y = Ozone, color = Temp), 
            , alpha = 1.0, size = 1) + 
  scale_color_gradientn(colours = c("darkblue", "blue", "red", "yellow", "lightyellow")) +
  scale_x_date(date_breaks = "1 month", date_labels = "%B", expand = c(0.05, 0)) + 
  labs(
    title = "New York Air Quality, 1973, May - October",
    y = "Ozone", 
    x = "Date"
  ) +
  theme_minimal()