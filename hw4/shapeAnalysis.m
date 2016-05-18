function C = shapeAnalysis(S1, TS)


% remove the noisy background
S1 = (S1 > 0) * 255;
% imwrite(uint8(S1), './rslt_images/Sample1_clean.png');

% heuristic trimming
TS = TS(10:240, 8:441);

[m, n] = size(TS);
m_slice = floor(m / 5);
n_slice = floor(n / 14);

for i = 1:5
    for j = 1:14
        data(:, :, (i - 1) * 14 + j) = TS((i - 1) * m_slice + 1:i * m_slice, (j - 1) * n_slice + 1:j * n_slice);
    end
end

n_data = length(data); % number of total data = 70

% uncomment the following three lines if you want to save each seperate
% data that appears in TrainingSet.raw
% for i = 1:n_data
%     imwrite(uint8(data(:, :, i)), ['/Users/Andy/Desktop/tmp/data', num2str(i), '.png']);
% end

