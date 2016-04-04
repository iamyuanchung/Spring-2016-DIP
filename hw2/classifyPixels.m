function I = classifyPixels(FM, k, m, n)

idx = kMeansCluster(FM', k);

I = zeros(m, n);
for i = 1:m * n
    cur_pos_i = mod(i - 1, m) + 1;
    cur_pos_j = ceil(i / m);
    if idx(i) == 1
        I(cur_pos_i, cur_pos_j) = 0;
    elseif idx(i) == 2
        I(cur_pos_i, cur_pos_j) = 80;
    elseif idx(i) == 3
        I(cur_pos_i, cur_pos_j) = 160;
    else
        I(cur_pos_i, cur_pos_j) = 240;
    end
end