function FM = lawsFeatureExtraction(G)
% ####################################################################### %
% lawsFeatureExtraction: Using Laws' method for extracting features of a  %
%                        given 2D image matrix                            %
%                                                                         %
%   Usage:                                                                %
%       FM = lawsFeatureExtraction(G)                                     %
%                                                                         %
%   Reference:                                                            %
%       [1] Page 19 of DIP_Lecture05_2016_Spring.pdf                      %
% ####################################################################### %

% define the 9 laws' masks
L1 = [1, 2, 1; 2, 4, 2; 1, 2, 1] / 36;
L2 = [1, 0, -1; 2, 0, -2; 1, 0, -1] / 12;
L3 = [-1, 2, -1; -2, 4, -2; -1, 2, -1] / 12;
L4 = [-1, -2, -1; 0, 0, 0; 1, 2, 1] / 12;
L5 = [1, 0, -1; 0, 0, 0; -1, 0, 1] / 12;
L6 = [-1, 2, -1; 0, 0, 0; 1, -2, 1] / 4;
L7 = [-1, -2, -1; 2, 4, 2; -1, -2, -1] / 12;
L8 = [-1, 0, 1; 2, 0, -2; -1, 0, 1] / 4;
L9 = [1, -2, 1; -2, 4, -2; 1, -2, 1] / 4;

[m, n] = size(G);

% expand G such that the resulting 9 matrices will have the same size as G
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

% convolve G_expand with each of the 9 laws' masks one by one and store
% them in M1, M2, ..., M9
M1 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M1(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L1));
    end
end

M2 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M2(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L2));
    end
end

M3 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M3(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L3));
    end
end

M4 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M4(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L4));
    end
end

M5 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M5(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L5));
    end
end

M6 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M6(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L6));
    end
end

M7 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M7(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L7));
    end
end

M8 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M8(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L8));
    end
end

M9 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M9(i, j) = sum(sum(G_expand(i:i + 2, j:j + 2) .* L9));
    end
end

% now we have M1 ~ M9