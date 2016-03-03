function G_out = flipVertical(G)
    % TODO
    [m, n] = size(G);
    G_out = zeros(m, n);
    for i = 1:m
        G_out(i, :) = G(m - i + 1, :);
    end
end