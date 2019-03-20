Training = importdata('Fire_Training.csv');
Validation = importdata('Fire_Validation.csv');

training_m = size(Training, 1)
validation_m = size(Validation, 1)

% Select 'FIRE_YEAR', 'DISCOVERY_DOY', 'LATITUDE','LONGITUDE', 'DURATION', and the fire cause columns
% as the features, and use 'FIRE_SIZE' as our training goal.
X_idx = [3 5 12 13 15:28];
Y_idx = 11;

% Log transform the fire size.
Training(:, Y_idx) = log10(Training(:, Y_idx));
Validation(:, Y_idx) = log10(Validation(:, Y_idx));

learning_m2 = training_m;
learning_val2 = training_m;
Training2x = featureNormalize(polyFeatures(Training(:, X_idx), 5, 2));
Validation2x = featureNormalize(polyFeatures(Validation(:, X_idx), 5, 2));
Training2y = Training(:, Y_idx);
Validation2y = Validation(:, Y_idx);

[lambda_vec, error_train, error_val] = validationCurve(Training2x, Training2y, Validation2x, Validation2y);

plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xscale('log');
xlabel('lambda');
ylabel('Error');
title('Selecting Regularization Parameter lambda');
saveas(gcf, "FireReg.png")

fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
	fprintf(' %f\t%f\t%f\n', ...
            lambda_vec(i), error_train(i), error_val(i));
end