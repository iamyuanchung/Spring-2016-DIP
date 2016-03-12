y_PSNR = zeros(1, length(1:20));
max_PSNR = 0;   % the maximum PSNR value achieved
max_b = 0;      % the corresponding b
for b = 1:20
    tmp = lowPassFilter(N2, b);
    y_PSNR(b) = calcPSNR(I, tmp);
    if y_PSNR(b) > max_PSNR
        max_PSNR = y_PSNR(b);
        max_b = b;
    end
end

plot(1:20, y_PSNR, 'b', max_b, max_PSNR, 'b*', 'MarkerSize', 24);
xlim([1, 20]);
xlabel('b', 'FontSize', 24);
ylabel('PSNR',  'FontSize', 24);
set(gca, 'FontSize', 24);

fprintf('The maximum PSNR value achieved by low-pass filter is %f, and the corresponding b = %f\n', max_PSNR, max_b);