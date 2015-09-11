library(readr)
library(dplyr)

## Uncomment the following lines to go from raw.
## Raw data should be unzipped in a "data" subdirectory.
## Cleaned data has also been saved to "data" subdirectory.

# powerConsumption <- read_delim("data/household_power_consumption.txt", delim = ";", na = "?")
# pcFeb <- powerConsumption %>%
#   filter(Date %in% c("1/2/2007", "2/2/2007"))
# save(pcFeb, file = "data/power_consumption_feb.Rdata")
# rm(list = ls())

load("data/power_consumption_feb.Rdata")
png(filename = "plot1.png", width = 480, height = 480, units = "px")
pcFeb %>%
  select(Global_active_power) %>%
  unlist %>%
  hist(col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
