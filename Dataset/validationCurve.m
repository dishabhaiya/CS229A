function [lambda_vec, error_train, error_val] = validationCurve(X, y, Xval, yval)

lambda_vec = [0 0.0003 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';

error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

m = size(X, 1);
mval = size(Xval, 1);
mvec = length(lambda_vec);
for i = 1:mvec
    [theta] = trainLinearReg([ones(m, 1) X], y, lambda_vec(i));
    [J grad] = linearRegCostFunction([ones(m, 1) X], y, theta, 0);
    error_train(i) = J;
    [Jval gradval] = linearRegCostFunction([ones(mval, 1) Xval], yval, theta, 0);
    error_val(i) = Jval;
end

end