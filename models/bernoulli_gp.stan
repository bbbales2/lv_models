data {
  int N;
  real x[N];
  int y[N];
}

parameters {
  vector[N] f;
  real<lower = 0.0> sigma;
  real<lower = 0.0> l;
}

model {
  matrix[N, N] Sigma = cov_exp_quad(x, sigma, l);
    
  for(n in 1:N)
    Sigma[n, n] = Sigma[n, n] + 1e-12;
      
  l ~ gamma(4, 4);
  f ~ multi_normal(rep_vector(0.0, N), Sigma);
  sigma ~ normal(0, 1);
  
  y ~ bernoulli_logit(f);
}