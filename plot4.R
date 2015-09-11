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

## Convert to datetime
pcFeb <- pcFeb %>%
  unite(DateTime, sep = " ", Date, Time) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")))

## subset the data
subMeter <- pcFeb %>%
  select(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

pcFeb %>%
  select(DateTime, Global_active_power) %>%
  plot(type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

pcFeb %>%
  select(DateTime, Voltage) %>%
  plot(type = "l", xlab = "datetime", ylab = "Voltage")

## Plot
plot(subMeter[1:2], type = "l", xlab = "", ylab = "Energy sub metering")
points(subMeter[c(1, 3)], type = "l", col = "red")
points(subMeter[c(1, 4)], type = "l", col = "blue")

## Add legend
legend("topright", bty = "n", legend = names(subMeter[-1]), col = c("black", "red", "blue"), lty = 1)

pcFeb %>%
  select(DateTime, Global_reactive_power) %>%
  plot(type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
