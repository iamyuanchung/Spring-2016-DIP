function G_out = flipHorizontal(G)
% ####################################################################### %
% logTransform: Flip the given 2D image matrix horizontally               %
%                                                                         %
%   Usage:                                                                %
%       G_out = flipHorizontal(G)                                         %
%                                                                         %
%   Description:                                                          %
%       I think the code is self-explained enough ...                     %
% ####################################################################### %

[m, n] = size(G);
G_out = zeros(m, n);
for j = 1:n
    G_out(:, j) = G(:, n - j + 1);
end