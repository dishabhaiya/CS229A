function [J, grad] = linearRegCostFunction(X, y, theta, lambda)

m = length(y);                         
J = 0;
grad = zeros(size(theta));

tmp_theta = theta(:);
tmp_theta(1) = 0;
J = sum((X * theta - y).^2) / (2 * m) + lambda / (2 * m) * sum(tmp_theta.^2);
grad = 1/m .* X' * (X * theta - y);
grad = grad + tmp_theta * lambda / m;

grad = grad(:);

end