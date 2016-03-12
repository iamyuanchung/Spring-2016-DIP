function G_fil = outlierDetection(G, epsilon)
% ####################################################################### %
%  outlierDetection: Perform outlier detection to remove the noise on the %
%                    given 2D image matrix.                               %
%                                                                         %
%   Usage:                                                                %
%       G_fil = outlierDetection(G, epsilon)                              %
%                                                                         %
%   Description:                                                          %
%       Outlier detection is used to remove the impulse noise like salt   %
%       and pepper. The method goes through each pixel one by one.        %
%       For each pixel p, the average intensity of its eight              %
%       neighbors is computed, and if |p - average| > epsilon, where      %
%       epsilon is the given threshold, then p will be viewed as an       %
%       outlier and replaced by the average.                              %
% ####################################################################### %

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
        neighbor_avg = (sum(sum(G_expand(i:i + 2, j:j + 2))) - G_expand(i + 1, j + 1)) / 8;
        if abs(G_expand(i + 1, j + 1) - neighbor_avg) > epsilon
            G_fil(i, j) = neighbor_avg;
        else
            G_fil(i, j) = G(i, j);
        end
    end
end