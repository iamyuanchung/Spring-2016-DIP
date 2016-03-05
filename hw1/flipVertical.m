function G_out = flipVertical(G)
% ####################################################################### %
% logTransform: Flip the given 2D image matrix vertically                 %
%                                                                         %
%   Usage:                                                                %
%       G_out = flipVertical(G)                                           %
%                                                                         %
%   Description:                                                          %
%       I think the code is self-explained enough ...                     %
% ####################################################################### %

[m, n] = size(G);
G_out = zeros(m, n);
for i = 1:m
    G_out(i, :) = G(m - i + 1, :);
end