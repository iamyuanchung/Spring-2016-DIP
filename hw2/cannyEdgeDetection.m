function EM = cannyEdgeDetection(G, T_high, T_low)
% ####################################################################### %
% cannyEdgeDetection: Perform Canny edge detection on the given 2D image  %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       EM = cannyEdgeDetection(G, T_high, T_low)                         %
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
G_expand = zeros(m + 4, n + 4);
G_expand(1, 3:end - 2) = G(2, :);
G_expand(2, 3:end - 2) = G(1, :);
G_expand(end, 3:end - 2) = G(end - 1, :);
G_expand(end - 1, 3:end - 2) = G(end, :);
G_expand(3:end - 2, 1) = G(:, 2);
G_expand(3:end - 2, 2) = G(:, 1);
G_expand(3:end - 2, end) = G(:, end - 1);
G_expand(3:end - 2, end - 1) = G(:, end);
G_expand(3:end - 2, 3:end - 2) = G;
% this part is not reflected exactly, however, it does not matter much ...
G_expand(1:2, 1:2) = G(1:2, 1:2);
G_expand(1:2, end - 1:end) = G(1:2, end - 1:end);
G_expand(end - 1:end, 1:2) = G(end - 1:end, 1:2);
G_expand(end - 1:end, end - 1:end) = G(end - 1:end, end - 1:end);

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
[Gr, Gc, no_use] = sobelEdgeDetection(G_smoothed, 0);
EM = (Gr .^ 2 + Gc .^ 2) .^ 0.5;

% Step #3: Non-maximal suppression - preserve all local maxima and remove
%          others in the edge map
theta = atand(Gc ./ Gr);  % theta(i, j) record the angle of the gradient pixel at location (i, j)
EM_new = zeros(m, n);     % EM_new is the edge map after non-maximal suppression
for i = 2:m - 1
    for j = 2:n - 1
        if ((theta(i, j) <= 22.5 && theta(i, j) >= -22.5) || (theta(i, j) >= 157.5 && theta(i, j) <= -157.5))
            % east-west comparision
            if (EM(i, j) > EM(i, j - 1) && EM(i, j) > EM(i, j + 1))
                % maximal: preserve current gradient pixel
                EM_new(i, j) = EM(i, j);
            end
        elseif ((theta(i, j) > 22.5 && theta(i, j) <= 67.5) || (theta(i, j) > -157.5 && theta(i, j) <= -112.5))
            % northeast-southwest comparison
            if (EM(i, j) > EM(i - 1, j + 1) && EM(i, j) > EM(i + 1, j - 1))
                EM_new(i, j) = EM(i, j);
            end
        elseif ((theta(i, j) > 67.5 && theta(i, j) <= 112.5) || (theta(i, j) > -112.5 && theta(i, j) <= -67.5))
            % north-south comparison
            if (EM(i, j) > EM(i - 1, j) && EM(i, j) > EM(i + 1, j))
                EM_new(i, j) = EM(i, j);
            end
        else
            % northwest-southeast comparison
            if (EM(i, j) > EM(i - 1, j - 1) && EM(i, j) > EM(i + 1, j + 1))
                EM_new(i, j) = EM(i, j);
            end
        end
    end
end

% Step #4: Double thresholding - edge pixels stronger than the high threshold (T_high)
%          are marked as strong; edge pixels weaker than the low threshold (T_low)
%          are suppressed and edge pixels between the T_high and T_low are marked as weak
lb = zeros(m, n);   % 2 for strong pixel (edge pixel); 1 for weak pixel (candidate pixel);
                    % 0 for non-edge pixel
for i = 1:m
    for j = 1:n
        if (EM_new(i, j) >= T_high)
            lb(i, j) = 2;
        elseif (EM_new(i, j) < T_high && EM_new(i, j) >= T_low)
            lb(i, j) = 1;
        end
    end
end

% Step #5: Connected component labeling - strong edges can immediately be included in the final
%          edge map; weak edges are included if and only if they are connected to strong edges.
for i = 1:m
    for j = 1:n
        if (lb(i, j) == 2)
            % strong edge can be immediately set as edge pixel
            EM(i, j) = 255;
        elseif (lb(i, j) == 1 && (lb(i - 1, j - 1) == 2 || lb(i - 1, j) == 2 || lb(i - 1, j + 1) == 2 ...
            || lb(i, j - 1) == 2 || lb(i, j + 1) == 2 || lb(i + 1, j - 1) == 2 || lb(i + 1, j) == 2   ...
            || lb(i + 1, j + 1) == 2))
            % weak strong can be included only if it is connected to any
            % strong edge within 8-connected neighborhood
            EM(i, j) = 255;
        else
            EM(i, j) = 0;
        end
    end
end