function G_fil = myMedianFilter(G)
% ####################################################################### %
%  myMedianFilter: 
%                                                                         %
%   Usage:                                                                %
%       G_fil = myMedianFilter(G)                                         %
%                                                                         %
%
% ####################################################################### %

[m, n] = size(G);
G_expand = zeros(m + 2, n + 2);
G_expand(1, 2:end - 1) = G(1, :);
G_expand(end, 2:end - 1) = G(end, :);
G_expand(2:end - 1, 1) = G(:, 1);
G_expand(2:end - 1, end) = G(:, end);
G_expand(1, 1) = G(1, 1);
G_expand(1, end) = G(1, end);
G_expand(end, 1) = G(end, 1);
G_expand(end, end) = G(end, end);
G_expand(2:end - 1, 2:end - 1) = G;

G_fil = zeros(m, n);
for i = 1:m
    for j = 1:n
        G_fil(i, j) = median(reshape(G_expand(i:i + 2, j:j + 2), 1, []));
    end
end