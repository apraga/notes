#stats #books
# Chap 2

## Linear vs nearest neighbours

-   linear model fitted by least squared = stable but possibly inaccurate
-   nearest neighbours = precise but unstable

If the data is a set of tightly lustered Gaussians (theirs means are distributed as Gaussian), the optimal will be nonlinear and disjoint If the data is a mixture of unrelated Gaussian, linear is almost optimal

## Bias, variance

### Bias
$$Bias_\theta(\hat{\theta})) = E_{x|\theta}(\hat{\theta}) - \theta$$
where $E_{x|\theta}$ is the expected value over \$(x\|θ) (average over all possible observations x with θ fixed)

Error from erroneous assumptions in the learning algorithm. High bias can cause an algorithm to miss the relevant relations between features and target outputs (underfitting).
### Variance :

Measure the dispersion : $$Variance(X) = E(X - E(X))^2$$
Error from sensitivity to small fluctuations in the training set. High variance may result from an algorithm modeling the random noise in the training data (overfitting).

## Curse of dimensionality = sparse sampling in hihg dimensions -\> it's harder to have enough training data

> we saw that squared error loss lead us to the regression function f
> (x) = E(Y \|X = x) for a quantitative response. The class of
> nearest-neighbor methods can be viewed as direct estimates of this
> conditional expectation, but we have seen that they can fail in at
> least two ways: • if the dimension of the input space is high, the
> nearest neighbors need not be close to the target point, and can
> result in large errors; • if special structure is known to exist, this
> can be used to reduce both the bias and the variance of the estimates.

Other models are design to overcome the dimensionality problems
