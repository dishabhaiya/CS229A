function X_norm = featureNormalize(X)

X_norm = X;
mu = mean(X);
sigma = std(X);

X_norm = bsxfun(@minus, X_norm, mu);
X_norm = bsxfun(@rdivide, X_norm, sigma);
end