function H = createRoundKernel(R)


m = 2 * R + 1;

H = [];
K = zeros(m, m);

for i = 1:m
    for j = 1:m
        if ((R + 1 - i) ^ 2 + (R + 1 - j) ^ 2 <= R ^ 2)
            K(i, j) = 1;
            H = [H; [i, j]];
        end
    end
end

H = H - R;