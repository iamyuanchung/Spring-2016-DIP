% N1 = imread('./sample1.salt.pepper.png');

y_PSNR = zeros(1, length(5:5:250));
i = 1;
max_PSNR = 0;       % the maximum PSNR value achieved
max_epsilon = 0;    % the corresponding epsilon
for epsilon = 5:5:250
    tmp = outlierDetection(N1, epsilon);
    y_PSNR(i) = calcPSNR(I, tmp);
    if y_PSNR(i) > max_PSNR
        max_PSNR = y_PSNR(i);
        max_epsilon = epsilon;
    end
    i = i + 1;
end

plot(5:5:250, y_PSNR, 'b', max_epsilon, max_PSNR, 'b*', 'MarkerSize', 24);
xlim([5, 250]);
xlabel('epsilon', 'FontSize', 24);
ylabel('PSNR',  'FontSize', 24);
set(gca, 'FontSize', 24);

fprintf('The maximum PSNR value achieved by outlier detection is %f, and the corresponding epsilon = %f\n', max_PSNR, max_epsilon);