function G = warpToGourdShape(S)

[m, n] = size(S);
assert((m == 512) && (n == 512));

G = zeros(size(S));
acc = zeros(size(S));

% handle A
width_A_half = 32;
window_size = 256 / width_A_half;
for j = 1:window_size:512
    G(1:64, 256 - width_A_half + (j - 1) / window_size + 1) = mean(S(1:64, j:j + window_size - 1), 2);
end

% handle B
% upper-left
for i = 65:176
    for j = 1:256
        if (255 * i - 111 * j - 16464 >= 0)
            p = 1;
        else
            p = 65;
            q = (16640 + 111 * j - 256 * i) / (176 - i);
            len_pq = ((p - 176) ^ 2 + (q - 256) ^ 2) ^ 0.5;
            len_ab = ((i - 176 ^ 2) + (j - 256) ^ 2) ^ 0.5;
        end
    end
end
