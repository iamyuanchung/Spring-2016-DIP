function FM = lawsFeatureExtraction(G, w)
% ####################################################################### %
% lawsFeatureExtraction: Using Laws' method for extracting features of a  %
%                        given 2D image matrix                            %
%                                                                         %
%   Usage:                                                                %
%       FM = lawsFeatureExtraction(G, w)                                  %
%                                                                         %
%   Reference:                                                            %
%       [1] Page 17 ~ 26 of DIP_Lecture05_2016_Spring.pdf                 %
% ####################################################################### %

% define the 9 laws' masks
H1 = [1, 2, 1; 2, 4, 2; 1, 2, 1] / 36;
H2 = [1, 0, -1; 2, 0, -2; 1, 0, -1] / 12;
H3 = [-1, 2, -1; -2, 4, -2; -1, 2, -1] / 12;
H4 = [-1, -2, -1; 0, 0, 0; 1, 2, 1] / 12;
H5 = [1, 0, -1; 0, 0, 0; -1, 0, 1] / 12;
H6 = [-1, 2, -1; 0, 0, 0; 1, -2, 1] / 4;
H7 = [-1, -2, -1; 2, 4, 2; -1, -2, -1] / 12;
H8 = [-1, 0, 1; 2, 0, -2; -1, 0, 1] / 4;
H9 = [1, -2, 1; -2, 4, -2; 1, -2, 1] / 4;

[m, n] = size(G);

% extend the boundary of G
G_extend = wextend('2D', 'sym', G, 1);

% convolve G_extend with each of the 9 laws' masks one by one and store
% them in M1, M2, ..., and M9, respectively
fprintf('\n    Convoluting the input image with H1 and producing M1 ...\n');
M1 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M1(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H1, 2)));
    end
end

fprintf('\n    Convoluting the input image with H2 and producing M2 ...\n');
M2 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M2(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H2, 2)));
    end
end

fprintf('\n    Convoluting the input image with H3 and producing M3 ...\n');
M3 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M3(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H3, 2)));
    end
end

fprintf('\n    Convoluting the input image with H4 and producing M4 ...\n');
M4 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M4(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H4, 2)));
    end
end

fprintf('\n    Convoluting the input image with H5 and producing M5 ...\n');
M5 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M5(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H5, 2)));
    end
end

fprintf('\n    Convoluting the input image with H6 and producing M6 ...\n');
M6 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M6(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H6, 2)));
    end
end

fprintf('\n    Convoluting the input image with H7 and producing M7 ...\n');
M7 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M7(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H7, 2)));
    end
end

fprintf('\n    Convoluting the input image with H8 and producing M8 ...\n');
M8 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M8(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H8, 2)));
    end
end

fprintf('\n    Convoluting the input image with H9 and producing M9 ...\n');
M9 = zeros(m, n);
for i = 1:m
    for j = 1:n
        M9(i, j) = sum(sum(G_extend(i:i + 2, j:j + 2) .* rot90(H9, 2)));
    end
end

% now we have M1 ~ M9, the next step is to extract features over a window
% that has a few cycles of the repetitive texture, and the feature
% extractions are done by computing region energy
% the argument w determines the window size for computing the
% region energy, and the obtained local features are stored in T1 ~ T9
fprintf('\n    Computing region energy of M1 and producing T1 ...\n');
T1 = zeros(m, n);
% extend the boundary of M1 to meet the given window size
M1_extend = wextend('2D', 'sym', M1, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        % region energy is defined as the sum of the square of intensities
        % within current window
        T1(i, j) = sum(sum(M1_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M2 and producing T2 ...\n');
T2 = zeros(m, n);
M2_extend = wextend('2D', 'sym', M2, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T2(i, j) = sum(sum(M2_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M3 and producing T3 ...\n');
T3 = zeros(m, n);
M3_extend = wextend('2D', 'sym', M3, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T3(i, j) = sum(sum(M3_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M4 and producing T4 ...\n');
T4 = zeros(m, n);
M4_extend = wextend('2D', 'sym', M4, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T4(i, j) = sum(sum(M4_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M5 and producing T5 ...\n');
T5 = zeros(m, n);
M5_extend = wextend('2D', 'sym', M5, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T5(i, j) = sum(sum(M5_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M6 and producing T6 ...\n');
T6 = zeros(m, n);
M6_extend = wextend('2D', 'sym', M6, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T6(i, j) = sum(sum(M6_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M7 and producing T7 ...\n');
T7 = zeros(m, n);
M7_extend = wextend('2D', 'sym', M7, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T7(i, j) = sum(sum(M7_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M8 and producing T8 ...\n');
T8 = zeros(m, n);
M8_extend = wextend('2D', 'sym', M8, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T8(i, j) = sum(sum(M8_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

fprintf('\n    Computing region energy of M9 and producing T9 ...\n');
T9 = zeros(m, n);
M9_extend = wextend('2D', 'sym', M9, (w - 1) / 2);
for i = 1:m
    for j = 1:n
        T9(i, j) = sum(sum(M9_extend(i:i + w - 1, j:j + w - 1) .^ 2));
    end
end

% FM stands for feature matrix of size 9 x (m * n) , where the j-th column
% is the feature vector of the j-th pixel, counting from top to bottom and
% from left to right (default of Matlab for accessing matrix)
fprintf('\n    Retrieving the feature matrix ...\n');
FM = zeros(9, m * n);
for j = 1:m * n
    % obtain current pixel
    cur_pos_i = mod(j - 1, m) + 1;
    cur_pos_j = ceil(j / m);
    FM(1, j) = T1(cur_pos_i, cur_pos_j);
    FM(2, j) = T2(cur_pos_i, cur_pos_j);
    FM(3, j) = T3(cur_pos_i, cur_pos_j);
    FM(4, j) = T4(cur_pos_i, cur_pos_j);
    FM(5, j) = T5(cur_pos_i, cur_pos_j);
    FM(6, j) = T6(cur_pos_i, cur_pos_j);
    FM(7, j) = T7(cur_pos_i, cur_pos_j);
    FM(8, j) = T8(cur_pos_i, cur_pos_j);
    FM(9, j) = T9(cur_pos_i, cur_pos_j);
end
