function G_grad = cannyEdgeDetection(G, T_high, T_low)
% ####################################################################### %
% cannyEdgeDetection: Perform Canny edge detection on the given 2D image  %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       G_grad = cannyEdgeDetection(G, T_high, T_low)                     %
%                                                                         %
%   Description:                                                          %
%       Canny edge detection includes 5 steps:                            %
%                                                                         %
%       1. Smoothing: we use a Gaussian smoothing filter to reduce the    %
%          noise, here we use a 5 x 5 Gaussian filter and set £m = 1.4     %
%                                                                         %
%       2. Finding large magnitude of gradients: we use the Sobel edge    %
%          detection method for finding gradients.                        %
%                                                                         %
%       3. Non-maximal suppression: after Sobel edge detection method is  %
%          applied, we preserve only the local maximas of the gradient    %
%          map G_grad. This is done by comparing each gradient pixel      %
%          G_grad(i, j) with two of its neighbor pixels, and only when    %
%          G_grad(i, j) is greater than both of its neighbor pixels will  %
%          it be preserved. The neighbor pixels to be compared with are   %
%          determined by G_grad(i, j)'s gradient orientation.             %
%                                                                         %
%       4. Double thresholding: the two thresholds T_high and T_low are   %
%          used to discriminate the so-called "strong" and "weak" edges:  %
%                                                                         %
%               label(i, j) = 2, if G_grad(i, j) >= T_high,               %
%                             1, if T_high > G_grad(i, j) >= T_low,       %
%                             0, else.                                    %
%                                                                         %
%          label will then be used to generate the resultant Canny edge   %
%          map in Step 5.                                                 %
%                                                                         %
%       5. Edge tracking: for those gradient pixels labeled as 2, they    %
%          are directly taken as edges; for those labeled as 0, they are  %
%          discarded immediately; and for those labeled as 1, they will   %
%          be preserved only when they are connected to at least one      %
%          strong edge (by 8-connected neighbor).                         %
%                                                                         %
%   Reference:                                                            %
%       [1] Page 18 ~ 22 of DIP_Lecture03_2016_Spring.pdf                 %
%       [2] http://www.cse.iitd.ernet.in/~pkalra/csl783/canny.pdf         %
% ####################################################################### %

[m, n] = size(G);

% extend the boundary of G
G_extend = wextend('2D', 'sym', G, 2);

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
        G_smoothed(i, j) = sum(sum(G_extend(i:i + 4, j:j + 4) .* rot90(Gaussian_filter, 2)));
    end
end

% Step #2: Compute gradient using sobel filter and store the gradients
%          magnitude in G_grad
[Gr, Gc, ~] = sobelEdgeDetection(G_smoothed, 0);
G_grad = (Gr .^ 2 + Gc .^ 2) .^ 0.5;

% Step #3: Non-maximal suppression - preserve all local maximas and rG_gradove
%          others in the edge map
theta = atand(Gc ./ Gr);  % theta(i, j) record the angle of the gradient pixel at location (i, j)
G_grad_new = zeros(m, n);     % G_grad_new is the gradient map after non-maximal suppression
for i = 2:m - 1
    for j = 2:n - 1
        if ((theta(i, j) <= 22.5 && theta(i, j) >= -22.5) || (theta(i, j) >= 157.5 && theta(i, j) <= -157.5))
            % east-west comparision
            if (G_grad(i, j) > G_grad(i, j - 1) && G_grad(i, j) > G_grad(i, j + 1))
                % maximal: preserve current gradient pixel
                G_grad_new(i, j) = G_grad(i, j);
            end
        elseif ((theta(i, j) > 22.5 && theta(i, j) <= 67.5) || (theta(i, j) > -157.5 && theta(i, j) <= -112.5))
            % northeast-southwest comparison
            if (G_grad(i, j) > G_grad(i - 1, j + 1) && G_grad(i, j) > G_grad(i + 1, j - 1))
                G_grad_new(i, j) = G_grad(i, j);
            end
        elseif ((theta(i, j) > 67.5 && theta(i, j) <= 112.5) || (theta(i, j) > -112.5 && theta(i, j) <= -67.5))
            % north-south comparison
            if (G_grad(i, j) > G_grad(i - 1, j) && G_grad(i, j) > G_grad(i + 1, j))
                G_grad_new(i, j) = G_grad(i, j);
            end
        else
            % northwest-southeast comparison
            if (G_grad(i, j) > G_grad(i - 1, j - 1) && G_grad(i, j) > G_grad(i + 1, j + 1))
                G_grad_new(i, j) = G_grad(i, j);
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
        if (G_grad_new(i, j) >= T_high)
            lb(i, j) = 2;
        elseif (G_grad_new(i, j) < T_high && G_grad_new(i, j) >= T_low)
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
            G_grad(i, j) = 255;
        elseif (lb(i, j) == 1 && (lb(i - 1, j - 1) == 2 || lb(i - 1, j) == 2 || lb(i - 1, j + 1) == 2 ...
            || lb(i, j - 1) == 2 || lb(i, j + 1) == 2 || lb(i + 1, j - 1) == 2 || lb(i + 1, j) == 2   ...
            || lb(i + 1, j + 1) == 2))
            % weak strong can be included only if it is connected to any
            % strong edge within 8-connected neighborhood
            G_grad(i, j) = 255;
        else
            G_grad(i, j) = 0;
        end
    end
end