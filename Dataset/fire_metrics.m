Training = importdata('Fire_Training.csv');
Test = importdata('Fire_Test.csv');

training_m = size(Training, 1)
test_m = size(Test, 1);

% Select 'FIRE_YEAR', 'DISCOVERY_DOY', 'LATITUDE','LONGITUDE', 'DURATION', and the fire cause columns
% as the features, and use 'FIRE_SIZE' as our training goal.
X_idx = [3 5 12 13 15:28];
Y_idx = 11;

% Log transform the fire size.
Training(:, Y_idx) = log10(Training(:, Y_idx));
Test(:, Y_idx) = log10(Test(:, Y_idx));

Training2x = featureNormalize(polyFeatures(Training(:, X_idx), 5, 2));
Test2x = featureNormalize(polyFeatures(Test(:, X_idx), 5, 2));
Training2y = Training(:, Y_idx);
Test2y = Test(:, Y_idx);

lambda = 0;
[theta] = trainLinearReg([ones(training_m, 1) Training2x], Training2y, lambda);

[theta_val, theta_idx] = sort(abs(theta));

num_theta = size(theta, 1);

for i = 1:10
	tmp = num_theta - i + 1;
	fprintf('Top %d: index %d\t value %f\n', i, theta_idx(tmp), theta(theta_idx(tmp)));
end

predictedY = [ones(test_m, 1) Test2x] * theta;
NRMSE = normalizeRMSE(predictedY, Test2y);
NRMSE

test_classes = assignFireSizeClass(Test2y);
predicted_classes = assignFireSizeClass(predictedY);

% Precision and recall various fire sizes
for i = 1:7
	tp = sum((test_classes == i) & (predicted_classes == i));
    fp = sum((predicted_classes == i) & (test_classes ~= i));
    fn = sum((predicted_classes ~= i) & (test_classes == i));
    prec = tp / (tp + fp);
    rec = tp / (tp + fn);
    F1 = 2 * (prec * rec) / (prec + rec);
    fprintf('Class %d: precision %f\t recall %f F1 %f\n', i, prec, rec, F1);
end