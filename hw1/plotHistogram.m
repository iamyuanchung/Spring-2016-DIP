function H = plotHistogram(G)
    % Input:  G - the input 2D matrix
    % Output: H - an array of length 256 where H(i) is the number of pixels
    %             whose pixel value equals to (i - 1)
    [m, n] = size(G);
    H = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            H(G(i, j) + 1) = H(G(i, j) + 1) + 1;
        end
    end
end