function G = erodeImage(F, H)


[m, n] = size(F);
len = length(H);

G = F;

for i = 1:m
    for j = 1:n
        reduce = 0;
        for k = 1:len
            if (i + H(k, 1) < 1 || i + H(k, 1) > m ...
             || j + H(k, 2) < 1 || j + H(k, 2) > n ...
             || F(i + H(k, 1), j + H(k, 2)) == 0)
                reduce = 1;
                break;
            end
        end
        if (reduce == 1)
            G(i, j) = 0;
        end
    end
end