function G_out = flipVertical(filename)
    % TODO
    disp(['Flipping ' filename ' vertically ...']);
    G = readraw(filename);
    [m, n] = size(G);
    G_out = zeros(m, n);
    for i = 1:m
        G_out(i, :) = G(m - i + 1, :);
    end
    writeraw(G_out, strcat(filename(1, 1:length(filename) - 4), '.vertical.raw'));
end