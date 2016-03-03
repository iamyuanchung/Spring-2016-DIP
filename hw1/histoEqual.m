function HE = histoEqual(G)
    % TODO
    [m, n] = size(G);
    H = zeros(1, 256);
    for i = 1:m
        for j = 1:n
            H(G(i, j) + 1) = H(G(i, j) + 1) + 1;
        end
    end
    
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