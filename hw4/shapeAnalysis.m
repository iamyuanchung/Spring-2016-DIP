function C = shapeAnalysis(S1, TS)


% remove the noisy background
S1 = (S1 > 0) * 255;
% imwrite(uint8(S1), './rslt_images/Sample1_clean.png');

[m, n] = size(S1);
m_slice = round(m / 5);
n_slice = round(n / 14);

for i = 1:5
    