function L = idealLowPass(F, r)


[m, n] = size(F);

L = F;
for i = 1:m
    for j = 1:n
        if ((m / 2 - i) ^ 2 + (n / 2 - j) ^ 2 > r ^ 2)
            L(i, j) = 0;
        end
    end
end