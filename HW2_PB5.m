k_len = 16;
k = (0:k_len - 1)';
x = power(k - 8, 3) / 8;

X = dct(x);
snr_list = zeros(1, k_len - 1);

for n = 0:k_len - 2
   temp_X_hat = X;
   temp_X_hat(k_len - n:k_len) = 0;
   temp_x_hat = idct(temp_X_hat);
   snr_list(n + 1)= snr(x, x - temp_x_hat);
end

snr_table = table((1:15)', snr_list');
snr_table.Properties.VariableNames = ["N", "SNR"];

plot((1:15), snr_list, '--', 'Color',[.6 0 0]);
title('Line Plot of Signal-to-Noise Ratio to N');
xlabel('N (number of trailing zeros)')
ylabel('Signal-to-Noise Ratio')
