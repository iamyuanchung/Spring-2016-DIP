function HE = histEqual(G)
    % Input: G - the input 2D matrix
    % Output: HE - the histogram equalized 2D matrix
    [m, n] = size(G);
    H = plotHistogram(G);

    % acc stands for accumulation
    acc = H;
    for i = 2:256
        acc(i) = acc(i) + acc(i - 1);
    end
    
    HE = zeros(m, n);
    for i = 1:m
        for j = 1:n
            HE(i, j) = round(acc(G(i, j) + 1) / (m * n) * 255);
        end
    end