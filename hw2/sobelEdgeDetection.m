function [Gr, Gc, EM] = sobelEdgeDetection(G, T)
% ####################################################################### %
% sobelEdgeDetection: Perform Sobel edge detection on the given 2D image  %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       [Gr, Gc, EM] = sobelEdgeDetection(G, T)                           %
%                                                                         %
%   Reference:                                                            %
%       [1] https://en.wikipedia.org/wiki/Sobel_operator                  %
% ####################################################################### %

[m, n] = size(G);

% expand G such that the resulting image will have the same size as G
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

% create Gr and Gc for storing row and column gradients, respectively
Gr = zeros(m, n);
Gc = zeros(m, n);

% define the two sobel filters
Kr = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Kc = [1, 2, 1; 0, 0, 0; -1, -2, -1];

% perform sobel edge detection
for i = 1:m
    for j = 1:n
        Gr(i, j) = sum(sum(G_expand(i: i + 2, j:j + 2) .* Kr));
        Gc(i, j) = sum(sum(G_expand(i: i + 2, j:j + 2) .* Kc));
    end
end

% compute and store the gradient magnitude in EM (edge map)
EM = (Gr .^ 2 + Gc .^ 2) .^ 0.5;

% only gradient pixel > T can be the edge pixels
EM = (EM > T) * 255.;