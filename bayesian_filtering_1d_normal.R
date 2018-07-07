library(tidyverse)
library(ggplot2)
library(rstan)
library(shinystan)

N = 50
sigma_x = 0.3
sigma_y = 0.3
x = rep(0, N)
x[1] = rnorm(1, 0.0, sigma_x)
for(i in 2:N) {
  x[i] = rnorm(1, x[i - 1], sigma_x);
}
y = sapply(x, function(x) { rnorm(1, x, sigma_y) })

list(t = 1:N, x = x, y = y) %>%
  as.tibble %>%
  gather(which, value, -t) %>%
  ggplot(aes(t, value)) +
  geom_point(aes(colour = which))

model = stan_model("models/bayesian_smoothing_1d_normal.stan")
fit = sampling(model,
               data = list(N = N,
                           y = y),
               cores = 1, chains = 1,
               iter = 2000)
corrplot(cor(extract(fit, pars = 'x')$x))

## Fit a sine wave now

x = sin(2 * pi * (1:N) / N)
y = sapply(x, function(x) { rnorm(1, x, sigma_y) })

list(t = 1:N, x = x, y = y) %>%
  as.tibble %>%
  gather(which, value, -t) %>%
  ggplot(aes(t, value)) +
  geom_point(aes(colour = which))

model = stan_model("models/bayesian_smoothing_1d_normal.stan")
fit = sampling(model,
               data = list(N = N,
                           y = y),
               cores = 1, chains = 1,
               iter = 2000)
corrplot(cor(extract(fit, pars = 'x')$x))
