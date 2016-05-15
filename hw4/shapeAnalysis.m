function C = shapeAnalysis(S1, TS)


%
S1_clean = (S1 > 0) * 255;
imwrite(uint8(S1_clean), './rslt_images/Sample1_clean.png');

W = zeros()