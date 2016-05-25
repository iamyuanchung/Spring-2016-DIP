function F = DFT(G)
% Reference: DIP_Lecture09_2016_Spring.pdf p.11

[M, N] = size(G);

F = zeros(M, N);
%%%%%%%%%%%%%%%%%%%%
%%% very slow!!! %%%
%%%%%%%%%%%%%%%%%%%%
for u = (-M / 2 + 1):M / 2
    for v = (-N / 2 + 1):N / 2
        fprintf('%d, %d\n', u, v);
        for j = 0:(M - 1)
            for k = 0:(N - 1)
                F(u + M / 2, v + N / 2) = F(u + M / 2, v + N / 2) + G(j + 1, k + 1) * exp(-1i * 2 * pi * (u * j / M + v * k / N));
            end
        end
    end
end