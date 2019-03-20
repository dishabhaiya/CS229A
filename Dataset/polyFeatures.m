function [X_poly] = polyFeatures(X, nonBinaryFeatures, order)

X_poly = [X];
m = size(X, 2);

% Second order terms.
for j = 2:order
	for i = 1:nonBinaryFeatures
		X_poly = [X_poly X(:, i).^j];
	end
end
size(X_poly)

% Interaction terms.
for i = 1:(nonBinaryFeatures - 1)
	for j = (i + 1):nonBinaryFeatures
		X_poly = [X_poly X(:, i) .* X(:, j)];
	end
end
size(X_poly)

for i = 1:nonBinaryFeatures
	for j = (nonBinaryFeatures + 1):m
		X_poly = [X_poly X(:, i) .* X(:, j)];
	end
end
size(X_poly)

end