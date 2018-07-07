data {
  int N;
  vector[N] y; 
}

parameters {
  real<lower = 0.0> sigma_x;
  real<lower = 0.0> sigma_y;
  vector[N] x;
}

model {
  x[1] ~ normal(0, sigma_x);

  for(i in 2:N) {
    x[i] ~ normal(x[i - 1], sigma_x);
  }

  y ~ normal(x, sigma_y);
}