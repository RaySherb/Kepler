#https://www.kaggle.com/keplersmachines/kepler-labelled-time-series-data/code

# Load libraries
library(tidyverse)
library(reshape2)

# Load data (Training Set)
kepler <- read_csv('exoTrain.csv')

# Extract the label column
kepler.labels <- kepler[,1]
kepler <- kepler[,-1]

# Rename columns
set_names(kepler, 1:ncol(kepler))
# Add a column of names to distinguish systems
kepler$system <- as.factor(1:nrow(kepler))
# Move system column to front
kepler <- kepler %>% select(system, everything())

# Gather into long format *worked without setting system to factor
test <- kepler[kepler$system == 1, ] %>% gather(key = time, value = flux, -system) %>% 
  ggplot(aes(x=time, y=flux))+
  geom_point()

#https://stackoverflow.com/questions/26536251/comparing-gather-tidyr-to-melt-reshape2
#https://stackoverflow.com/questions/3777174/plotting-two-variables-as-lines-using-ggplot2-on-the-same-graph
##############################################################
# Data description:
# Timeseries data recording flux (light intensity) of stars
# 
# Labels:
# ----------------
# 2: Star has at least 1 confirmed exo-planet
# 1: Star has no confirmed exo-planets
##############################################################

# Stars as columns, time in rows (long format)
keplert <- as.data.frame(t(kepler))

# planet systems:
planets <- keplert[, kepler[1, ] == 2]
planets <- planets[-1, ] #%>% mutate(time=1:(nrow(planets)-1))

planets %>% ggplot(aes(x=1:nrow(planets))) +
  geom_line(aes(y=V5))


# Add row of time
kepler <- 1:ncol(kepler) %>% rbind(kepler)

