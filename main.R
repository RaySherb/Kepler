#https://www.kaggle.com/keplersmachines/kepler-labelled-time-series-data/code

# Load libraries
library(tidyverse)
library(reshape2)

# Load data (Training Set)
kepler <- read_csv('exoTrain.csv')

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
keplerTime <- 1:ncol(kepler) %>% rbind(kepler)

