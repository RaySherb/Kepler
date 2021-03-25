#https://www.kaggle.com/keplersmachines/kepler-labelled-time-series-data/code
##############################################################
# Data description:
# Timeseries data recording flux (light intensity) of stars
# 
# Labels:
# ----------------
# 2: Star has at least 1 confirmed exo-planet
# 1: Star has no confirmed exo-planets
##############################################################
# Load libraries
library(tidyverse)

# Load data (Training Set)
kepler <- read_csv('exoTrain.csv')

# Extract the label column
kepler.labels <- kepler[,1]
kepler <- kepler[,-1]

# Scale features with Normalization (x-min)/(max-min)
keplerN <- as_tibble(t(apply(kepler, 1, function(x){
  (x-min(x))/(max(x)-min(x))
})))


# Gather into long format for plotting
keplerG <- keplerN %>% mutate(system = 1:nrow(keplerN)) %>%
  gather(key = time, value = flux, -system)
# build a plot
keplerG[keplerG$system %in% c(200,3), ] %>% ggplot(aes(x=time, y=flux))+
  geom_point(alpha=0.1)














# Rename columns
# kepler <- set_names(kepler, 1:ncol(kepler))
# Add a column of names to distinguish systems *This was causing problems with min/max function
# kepler$system <- as.factor(1:nrow(kepler))

# Add column of min and max
kepler[, 'max'] <- apply(kepler[, 1:(ncol(kepler)-1)], 1, max)
kepler$min <- apply(kepler, 1, min)
# Move new columns to front
kepler <- kepler %>% select(max, min, everything())







#https://stackoverflow.com/questions/26536251/comparing-gather-tidyr-to-melt-reshape2
#https://stackoverflow.com/questions/3777174/plotting-two-variables-as-lines-using-ggplot2-on-the-same-graph



