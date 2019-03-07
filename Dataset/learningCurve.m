function [error_train, error_val] = learningCurve(X, y, Xval, yval, lambda)

	m = size(X, 1);

	error_train = zeros(m, 1);
	error_val   = zeros(m, 1);

	mval = size(Xval, 1);
	for i = 1:m
	    [theta] = trainLinearReg([ones(i, 1) X(1:i, :)], y(1:i), lambda);
	    [J grad] = linearRegCostFunction([ones(i, 1) X(1:i, :)], y(1:i), theta, 0);
	    error_train(i) = J;
	    [Jval gradval] = linearRegCostFunction([ones(mval, 1) Xval], yval, theta, 0);
	    error_val(i) = Jval;
	end

end