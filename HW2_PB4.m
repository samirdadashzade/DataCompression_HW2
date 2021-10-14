k = (0:15)';
x = power(k - 8, 3) / 8;
y = cos((3*k+1)*pi/16+1)+sin((5*k+1)*pi/16);

hadamardMatrix = sqrt(1/length(k)) * hadamard(length(k));

X = hadamardMatrix * x;
Y = hadamardMatrix * y;

X_mag = abs(X);
Y_mag = abs(Y);

X_maxOfTenMin = max(mink(X_mag, 10));
Y_maxOfTenMin = max(mink(Y_mag, 10));

X_smallerIndices = X_mag(:) > X_maxOfTenMin;
Y_smallerIndices = Y_mag(:) > Y_maxOfTenMin;

X_hat = X_smallerIndices .* X;
Y_hat = Y_smallerIndices .* Y;

x_hat = inv(hadamardMatrix) * X_hat;
y_hat = inv(hadamardMatrix) * Y_hat;

table1 = table(k, X, X_mag, X_hat);
table2 = table(k, Y, Y_mag, Y_hat);
table3 = table(k, x, x_hat);
table4 = table(k, y, y_hat);

x_mse = immse(x, x_hat);
y_mse = immse(y, y_hat);

labels = ["X"; "Y"];
statTable = table(labels, [x_mse; y_mse]);
statTable.Properties.VariableNames = ["Label", "MSE"];

x_hat_4 = x_hat;
y_hat_4 = y_hat;
mse_4 = [x_mse; y_mse];

table_mse = table(labels, mse_2, mse_3, mse_4);

figure(1)
plot([x, x_hat_2, x_hat_3, x_hat_4]);
title('Line Plot between x and a set of x (hat) (Fourier, DCT, Hadamard)', 'FontSize',14, 'FontWeight','bold');
legend('x', 'x (hat) Fourier', 'x (hat) DCT', 'x (hat) Hadamard');
xlabel('k', 'FontSize',14,'FontWeight','bold');
ylabel('Set of x^', 'FontSize',14,'FontWeight','bold');

figure(2)
plot([y, y_hat_2, y_hat_3, y_hat_4]);
title('Line Plot between y and a set of y (hat) (Fourier, DCT, Hadamard)', 'FontSize',14, 'FontWeight','bold');
legend('y', 'y (hat) Fourier', 'y (hat) DCT', 'y (hat) Hadamard');
xlabel('k', 'FontSize',14,'FontWeight','bold');
ylabel('Set of y^', 'FontSize',14,'FontWeight','bold');
