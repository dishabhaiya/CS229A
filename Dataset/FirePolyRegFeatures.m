Training = importdata('Fire_Training.csv');
Validation = importdata('Fire_Validation.csv');
%Test = importdata('Fire_Test.csv');

training_m = size(Training, 1)
validation_m = size(Validation, 1)
%test_m = size(Test, 1)

% Select 'FIRE_YEAR', 'DISCOVERY_DOY', 'LATITUDE','LONGITUDE', 'DURATION', and the fire cause columns
% as the features, and use 'FIRE_SIZE' as our training goal.
X_idx = [3 5 12 13 15:28];

Y_idx = 11;

Training2x = featureNormalize(Training(:, X_idx));
Training2x(1, :)
Training2y = Training(:, Y_idx);
Validation_x = featureNormalize(Validation(:, X_idx));
Validation_y = Validation(:, Y_idx);

lambda = 0;
[theta] = trainLinearReg([ones(training_m, 1) Training2x], Training2y, lambda)

'With all features'
% Print training cost.
[J1 grad1] = linearRegCostFunction([ones(training_m, 1) Training2x], Training2y, theta, 0);
[J2 grad2] = linearRegCostFunction([ones(validation_m, 1) Validation_x], Validation_y, theta, 0);
fprintf('Training cost: %f | Test cost: %f\r', J1, J2);

'features'
for i = 1:5
	new_x_idx = zeros(1, size(X_idx, 2));
	new_x_idx(:, :) = X_idx;
	new_x_idx(:, i) = []

	Training2x = featureNormalize(Training(:, new_x_idx));
	Validation_x = featureNormalize(Validation(:, new_x_idx));

	lambda = 0;
	[theta] = trainLinearReg([ones(training_m, 1) Training2x], Training2y, lambda)

	% Print training cost.
	[J3 grad1] = linearRegCostFunction([ones(training_m, 1) Training2x], Training2y, theta, 0);
	[J4 grad2] = linearRegCostFunction([ones(validation_m, 1) Validation_x], Validation_y, theta, 0);
	fprintf('%f | Training cost: %f | Test cost: %f\r', i, J3 / J1, J4 / J2);
end

'without fire cause'
new_x_idx = [3 5 12 13 15];
Training2x = featureNormalize(Training(:, new_x_idx));
Validation_x = featureNormalize(Validation(:, new_x_idx));

lambda = 0;
[theta] = trainLinearReg([ones(training_m, 1) Training2x], Training2y, lambda)

% Print training cost.
[J3 grad1] = linearRegCostFunction([ones(training_m, 1) Training2x], Training2y, theta, 0);
[J4 grad2] = linearRegCostFunction([ones(validation_m, 1) Validation_x], Validation_y, theta, 0);
fprintf('%f | Training cost: %f | Test cost: %f\r', i, J3 / J1, J4 / J2);