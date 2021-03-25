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

# Scale features with Standardization (x-mu)/sigma
keplerS <- as_tibble(t(apply(kepler, 1, function(x){
  (x-mean(x))/sd(x)
})))

# Add column of min and max
keplerS[, 'max'] <- apply(keplerS[, 1:ncol(keplerS)], 1, max)
keplerS$min <- apply(keplerS, 1, min)
# Move new columns to front
keplerS <- keplerS %>% select(max, min, everything())


# Gather into long format for plotting
keplerG <- keplerS[, -c(1:2)] %>% mutate(system = 1:nrow(keplerS)) %>%
  gather(key = time, value = flux, -system)
# build a plot
keplerG[keplerG$system %in% c(200,3), ] %>% 
  ggplot(aes(x=time, y=flux, color=as.factor(system)))+
  geom_point(alpha=0.1)



