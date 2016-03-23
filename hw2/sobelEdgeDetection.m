function EM = sobelEdgeDetection(G)
% ####################################################################### %
% sobelEdgeDetection: Perform Sobel edge detection on the given 2D image  %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       EM = sobelEdgeDetection(G)                                        %
%                                                                         %
%   Reference:                                                            %
%       Page 15 of DIP_Lecture03_2016_Spring.pdf                          %
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

% perform sobel edge detection
for i = 1:m
    for j = 1:n
        Gr(i, j) = (G_expand(i, j + 2) + 2 * G_expand(i + 1, j + 2) + G_expand(i + 2, j + 2)) ...
                 - (G_expand(i, j) + 2 * G_expand(i + 1, j) + G_expand(i + 2, j));
        Gc(i, j) = (G_expand(i, j) + 2 * G_expand(i, j + 1) + G_expand(i, j + 2)) ...
                 - (G_expand(i + 2, j) + 2 * G_expand(i + 2, j + 1) + G_expand(i + 2, j + 2));
    end
end

Gr = Gr / 4;
Gc = Gc / 4;

% compute and store the gradient magnitude in EM (edge map)
EM = (Gr .^ 2 + Gc .^ 2) .^ 0.5;