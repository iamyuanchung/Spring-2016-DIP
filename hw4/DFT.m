function F = DFT(G)
% Reference: DIP_Lecture09_2016_Spring.pdf p.11

[M, N] = size(G);

F = zeros(M, N);
%%%%%%%%%%%%%%%%%%%%
%%% very slow!!! %%%
%%%%%%%%%%%%%%%%%%%%
for u = 1:M
    if (mod(u, 10) == 0)
        fprintf('%d\n', u);
    end
    for v = 1:N
        for j = 0:(M - 1)
            for k = 0:(N - 1)
                F(u, v) = F(u, v) + exp(-1i * 2 * pi * ((u - M / 2) * j / M + (v - N / 2) * k / N));
            end
        end
    end
end

F = F / (M * N);