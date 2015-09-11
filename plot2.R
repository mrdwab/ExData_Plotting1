library(readr)
library(dplyr)
library(tidyr)

## Uncomment the following lines to go from raw.
## Raw data should be unzipped in a "data" subdirectory.
## Cleaned data has also been saved to "data" subdirectory.

# powerConsumption <- read_delim("data/household_power_consumption.txt", delim = ";", na = "?")
# pcFeb <- powerConsumption %>%
#   filter(Date %in% c("1/2/2007", "2/2/2007"))
# save(pcFeb, file = "data/power_consumption_feb.Rdata")
# rm(list = ls())

load("data/power_consumption_feb.Rdata")
png(filename = "plot2.png", width = 480, height = 480, units = "px")
pcFeb %>%
  unite(DateTime, sep = " ", Date, Time) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime, format = "%d/%m/%Y %H:%M:%S"))) %>%
  select(DateTime, Global_active_power) %>%
  plot(type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
