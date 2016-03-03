function G_out = flipHorizontal(G)
    % TODO
    [m, n] = size(G);
    G_out = zeros(m, n);
    for j = 1:n
        G_out(:, j) = G(:, n - j + 1);
    end
end