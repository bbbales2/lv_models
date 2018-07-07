library(tidyverse)
library(brms)

data(bball1970)
bball <- bball1970

fit = brm(cbind(Hits, AB - Hits) ~ (1 | Player),
    data = bball,
    family = binomial("logit"))

write(stancode(fit), file = "models/efron.stan")
standata(fit)
