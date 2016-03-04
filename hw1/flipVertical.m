function G_out = flipVertical(G)
    % Input:  G - the input 2D matrix
    % Output: G_out - the vertically flipped 2D matrix
    [m, n] = size(G);
    G_out = zeros(m, n);
    for i = 1:m
        G_out(i, :) = G(m - i + 1, :);
    end
end