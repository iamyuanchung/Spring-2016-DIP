function G = invDFT(F)
% Reference: DIP_Lecture09_2016_Spring.pdf p.11

[m, n] = size(F);

G = zeros(m, n);
for a = 1:m
    for b = 1:n
        for k = 1:m
            for l = 1:n
                G(a, b) = G(a, b) + F(k, l) * exp(1i * 2 * pi * (k * a / m + l * b / n));
            end
        end
        G(a, b) = G(a, b) / (m * n);
    end
end