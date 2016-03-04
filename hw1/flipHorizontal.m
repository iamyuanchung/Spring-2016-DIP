function G_out = flipHorizontal(G)
    % Input:  G - the input 2D matrix
    % Output: G_out - the horizontally flipped 2D matrix
    [m, n] = size(G);
    G_out = zeros(m, n);
    for j = 1:n
        G_out(:, j) = G(:, n - j + 1);
    end
end