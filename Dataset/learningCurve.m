function [error_train, error_val] = learningCurve(X, y, Xval, yval, lambda)

	ratio = 50000;
	m = size(X, 1);
	n = floor(m / ratio);

	error_train = zeros(n, 1);
	error_val   = zeros(n, 1);

	mval = size(Xval, 1);
	for j = 1:n
		i = j * ratio;
	    [theta] = trainLinearReg([ones(i, 1) X(1:i, :)], y(1:i), lambda);
	    [J grad] = linearRegCostFunction([ones(i, 1) X(1:i, :)], y(1:i), theta, 0);
	    error_train(j) = J;
	    [Jval gradval] = linearRegCostFunction([ones(mval, 1) Xval], yval, theta, 0);
	    error_val(j) = Jval;
	end

end