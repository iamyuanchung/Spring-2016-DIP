function G_fil = lowPassFilter(G, b)
% ####################################################################### %
%  lowPassFilter: Perform low-pass filter to remove the noise on the      %
%                 given 2D image matrix.                                  %
%                                                                         %
%   Usage:                                                                %
%       G_fil = lowPassFilter(G, b)                                       %
%                                                                         %
%   Description:                                                          %
%       Low-pass filter is usually used to remove the uniform noise such  %
%       as Gaussian noise. The general form of a 3x3 low-pass filter is   %
%       as follows:                                                       %
%                     [  1    b    1  ]                                   %
%                     [  b   b^2   b  ] * 1 / (b + 2)^2.                  %
%                     [  1    b    1  ]                                   %
%                                                                         %
%       The filter goes through the given image from top to bottom, from  %
%       left to right and performs convolution. When b = 1, the new pixel %
%       value is simply the average of those elements (9 elements) inside %
%       the filter region.                                                %
%                                                                         %
%   Reference:                                                            %
%       Course slide of lecture 2.                                        %
% ####################################################################### %

% Create the 3x3 mask based on the given b
mask = ones(3, 3); 
mask(1, 2) = b;
mask(2, 1) = b;
mask(2, 2) = b ^ 2;
mask(2, 3) = b;
mask(3, 2) = b;
mask = mask / (b + 2) ^ 2;

[m, n] = size(G);

% Expand G such that the resulting image will have the same size as G.
G_expand = zeros(m + 2, n + 2);
G_expand(1, 2:end - 1) = G(1, :);
G_expand(end, 2:end - 1) = G(end, :);
G_expand(2:end - 1, 1) = G(:, 1);
G_expand(2:end - 1, end) = G(:, end);
G_expand(1, 1) = G(1, 1);
G_expand(1, end) = G(1, end);
G_expand(end, 1) = G(end, 1);
G_expand(end, end) = G(end, end);
G_expand(2:end - 1, 2:end - 1) = G;

G_fil = zeros(m, n);
for i = 1:m
    for j = 1:n
        G_fil(i, j) = sum(sum(mask .* G_expand(i:i + 2, j:j + 2)));
    end
end