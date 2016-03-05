function H = plotHistogram(G)
% ####################################################################### %
% plotHistogram: Calculate the pixel value distribution of a given 2D     %
%                image matrix                                             %
%                                                                         %
%   Usage:                                                                %
%       H = plotHistogram(G)                                              %
%                                                                         %
%   Description:                                                          %
%       plotHistogram(G) does not really "plot" the histogram, it visits  %
%       each entry of G one by one and accumulates the pixel value.       %
%       H is an array of length 256 where H(i) stores the number of       %
%       pixels whose pixel value equals to (i - 1).                       %
% ####################################################################### %

[m, n] = size(G);
H = zeros(1, 256);
for i = 1:m
    for j = 1:n
        H(G(i, j) + 1) = H(G(i, j) + 1) + 1;
    end
end