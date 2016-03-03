function H = plotHistogram(G)
    % TODO
    [m, n] = size(G);
    H = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            H(G(i, j) + 1) = H(G(i, j) + 1) + 1;
        end
    end
end