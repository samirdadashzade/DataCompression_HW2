k = (0:15)';
x = power(k - 8, 3) / 8;
y = cos((3*k+1)*pi/16+1)+sin((5*k+1)*pi/16);

X = dct(x);
Y = dct(y);

X_hat = X;
X_hat(7:16) = 0;

Y_hat = Y;
Y_hat(7:16) = 0;

x_hat = idct(X_hat);
y_hat = idct(Y_hat);

table1 = table(k, X, X_hat);
table2 = table(k, Y, Y_hat);
table3 = table(k, x, x_hat);
table4 = table(k, y, y_hat);

x_mse = immse(x, x_hat);
y_mse = immse(y, y_hat);

x_snr = snr(x, x - x_hat);
y_snr = snr(y, y - y_hat);

labels = ["X"; "Y"];
mse = [x_mse; y_mse];
snr = [x_snr; y_snr];

statTable = table(labels, mse, snr);

% export
x_hat_3 = x_hat;
y_hat_3 = y_hat;
mse_3 = mse;

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

