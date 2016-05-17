function G = dilateImage(F, H)


[m, n] = size(F);
len = length(H);

G = zeros(m, n);

for i = 1:m
    for j = 1:n
        if (F(i, j) == 255)
            for k = 1:len
                if (i + H(k, 1) > 0 && i + H(k, 1) <= m ...
                 && j + H(k, 2) > 0 && j + H(k, 2) <= n)
                    G(i + H(k, 1), j + H(k, 2)) = 255;
                end
            end
        end
    end
end