library(tidyverse)
library(ggplot2)
library(rstan)

df = read_csv('data/rw_nba.csv') %>%
  sample_n(100)

sdata = list(N = nrow(df),
             x = df$x,
             y = df$result)

fit = stan('models/bernoulli_gp.stan', data = sdata, chains = 1, cores = 1, iter = 1000)
