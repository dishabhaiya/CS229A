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
learning_val2 = validation_m;
Training2x = featureNormalize(Training(1:learning_m2, X_idx));
Training2x(1, :)
Training2y = Training(1:learning_m2, Y_idx);
Validation2x = featureNormalize(Validation(1:learning_val2, X_idx));
Validation2y = Validation(1:learning_val2, Y_idx);

lambda = 0;
[error_train2, error_val2] = learningCurve(Training2x, Training2y, Validation2x, Validation2y, lambda);
tmp_n = floor(learning_m2 / 50000);
tmp = [1:tmp_n] * 50000;
plot(tmp, error_train2, tmp, error_val2);
title('Learning curve for linear regression with log transformed fire sizes')
legend('Train', 'Validation')
xlabel('Number of training examples')
ylabel('Error')
saveas(gcf, "LinRegLog.png")