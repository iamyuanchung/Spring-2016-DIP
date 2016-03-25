function EM = cannyEdgeDetection(G)
% ####################################################################### %
% cannyEdgeDetection: Perform Canny edge detection on the given 2D image  %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       EM = cannyEdgeDetection(G)                                        %
%                                                                         %
%   Description:                                                          %
%       TODO
%
%   Reference:                                                            %
%       [1] Page 18 ~ 22 of DIP_Lecture03_2016_Spring.pdf                 %
%       [2] http://www.mathworks.com/help/images/edge-detection.html      %
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

% Step #1: Noise reduction - smooth the image with a Gaussian filter with
%          a standard deviation £m = 1.4 and store the smoothed image in
%          G_smoothed
Gaussian_filter = [
    2, 4, 5, 4, 2;
    4, 9, 12, 9, 4;
    5, 12, 15, 12, 5;
    4, 9, 12, 9, 4;
    2, 4, 5, 4, 2;
] / 159;

G_smoothed = zeros(m, n);

for i = 1:m
    for j = 1:n
        G_smoothed(i, j) = sum(sum(G_expand(i:i + 4, j:j + 4) .* Gaussian_filter));
    end
end

% Step #2: Compute gradient using sobel filter and store the gradients
%          magnitude in EM (edge map)
[Gr, Gc, EM] = sobelEdgeDetection(G_smoothed);

% Step #3: Non-maximal suppression - preserve all local maxima and remove
%          others in the edge map
theta = atand(Gc ./ Gr);  % theta(i, j) record the angle of the gradient pixel at location (i, j)
for i = 1:m
    for j = 1:n
        if (theta(i, j))
    end
end

% Step #4: Double thresholding


% Step #5: Connected component labeling