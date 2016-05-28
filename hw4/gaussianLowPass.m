function G = gaussianLowPass(F, r)


[m, n] = size(F);

G = F;
for i = 1:m
    for j = 1:n
        G(i, j) = G(i, j) * exp(((m / 2 - i) ^ 2 + (n / 2 - j) ^ 2) / (2 * r ^ 2));
    end
end