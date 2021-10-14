k = (0:15)';
x = power(k - 8, 3) / 8;
y = cos((3*k+1)*pi/16+1)+sin((5*k+1)*pi/16);

X = fft(x);
Y = fft(y);

X_mag = abs(X);
Y_mag = abs(Y);

X_maxOfTenMin = max(mink(X_mag, 10));
Y_maxOfTenMin = max(mink(Y_mag, 10));

X_smallerIndices = X_mag(:) > X_maxOfTenMin;
Y_smallerIndices = Y_mag(:) > Y_maxOfTenMin;

X_hat = X_smallerIndices .* X;
Y_hat = Y_smallerIndices .* Y;

x_hat = ifft(X_hat);
y_hat = ifft(Y_hat);

x_mse = immse(x, x_hat);
y_mse = immse(y, y_hat);

x_snr = snr(x, x- x_hat);
y_snr = snr(y, y - y_hat);

label = ["X"; "Y"];
mse = [x_mse; y_mse];
snr = [x_snr; y_snr];

statTable = table(label, mse, snr);
table1 = table(k, X, X_mag, X_hat);
table2 = table(k, Y, Y_mag, Y_hat);
table3 = table(k, x, x_hat);
table4 = table(k, y, y_hat);

% export
x_hat_2 = x_hat;
y_hat_2 = y_hat;
mse_2 = mse;

figure(1)
plot(x, '--', 'Color',[.6 0 0])
hold on
plot(x_hat, '-', 'Color',[0 .6 0])
hold off
title('Line Plot of x and x^', 'FontSize',14, 'FontWeight','bold');
legend('x', 'x (hat) Fourier');
xlabel('k', 'FontSize',14,'FontWeight','bold');

figure(2)
plot(y, '--', 'Color',[.6 0 0])
hold on
plot(y_hat, '-', 'Color',[0 .6 0])
hold off
title('Line Plot of y and y^', 'FontSize',14, 'FontWeight','bold');
legend('y', 'y (hat) Fourier');
xlabel('k', 'FontSize',14,'FontWeight','bold');
