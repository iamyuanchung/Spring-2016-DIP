function HE = histEqual(G)
% ####################################################################### %
% histEqual: Perform histogram equalization on the given 2D image matrix  %
%                                                                         %
%   Usage:                                                                %
%       HE = histEqual(G)                                                 %
%                                                                         %
%   Description:                                                          %
%       histEqual(G) tries to balance the pixel value distribution of G,  %
%       whose histogram originally tends to be imbalanced.                %
% ####################################################################### %

[m, n] = size(G);

% We need the pixel value distribution before performing histogram
% equalzation
H = plotHistogram(G);

% acc stands for accumulation
acc = H;
for i = 2:256
	acc(i) = acc(i) + acc(i - 1);
end
    
HE = zeros(m, n);
for i = 1:m
    for j = 1:n
        HE(i, j) = round(acc(G(i, j) + 1) / (m * n) * 255);
    end
end