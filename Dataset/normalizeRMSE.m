function NRMSE = normalizeRMSE(predictedY, Y)

RMSE = sum((predictedY - Y).^2) / size(Y, 1);
RMSE
range = max(Y) - min(Y);

NRMSE = RMSE / range;
end