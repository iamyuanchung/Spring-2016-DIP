function LHE = localHistoEqual(G)
    % TODO
    % Reference: http://angeljohnsy.blogspot.com/2011/06/local-histogram-equalization.html
    [m, n] = size(G);
    G_new = zeros(m + 2, n + 2);
    G_new(2:end - 1, 2:end - 1) = G;
    [m_new, n_new] = size(G_new);
    LHE = zeros(m, n);
    for i = 1:m_new - 2
        for j = 1:n_new - 2
            HE = histoEqual(G_new(i:i + 2, j:j + 2));
            LHE(i, j) = HE(2, 2);
        end
    end
end