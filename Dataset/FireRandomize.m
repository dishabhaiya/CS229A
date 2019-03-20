filename = "fire_relevant.csv";
delimiterIn = ',';
headerlinesIn = 1;
fire_data = importdata(filename, delimiterIn, headerlinesIn);
[m, n] = size(fire_data.data)

data = fire_data.data;

% 15th column: fire duration.
duration = fire_data.data(:, 8) .- fire_data.data(:, 4);
data = [data duration];

% 16th to 28th column: fire cause.
for i = 1:13
    data = [data fire_data.data(:, 7) == i];
end

% Split the dataset into 60% training, 20% validation, and 20% test data.
P = [0.6 0.2 0.2];
idx = randperm(m);
Training = data(idx(1:round(P(1) * m)), :); 
Validation = data(idx((round(P(1) * m) + 1) : round((P(1) + P(2)) * m)), :);
Test = data(idx(round(((P(1) + P(2)) * m) + 1) : m), :);

csvwrite("Fire_Training.csv",Training);
csvwrite("Fire_Validation.csv",Validation);
csvwrite("Fire_Test.csv",Test);
