function G_out = flipHorizontal(filename)
    % TODO
    disp(['Flipping ' filename ' horizontally ...']);
    G = readraw(filename);
    [m, n] = size(G);
    G_out = zeros(m, n);
    for j = 1:n
        G_out(:, j) = G(:, n - j + 1);
    end
    writeraw(G_out, strcat(filename(1, 1:length(filename) - 4), '.horizontal.raw'));
end