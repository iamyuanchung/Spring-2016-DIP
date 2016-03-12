function G_fil = myMedianFilter(G)
% ####################################################################### %
%  myMedianFilter: Perform median filtering to remove the noise on the    %
%                  given 2D image matrix                                  %
%                                                                         %
%   Usage:                                                                %
%       G_fil = myMedianFilter(G)                                         %
%                                                                         %
%   Description:                                                          %
%       Since there exists a built-in function called medianFilter in     %
%       Matlab, I name after mine as myMedianFilter. Median filter is     %
%       used to remove the impulse noise like salt and pepper.            %
%       The method uses a 3x3 filter that goes through the image from     %
%       top to bottom and from left to right, the elements inside the     %
%       filter (9 elements) are sorted and the median is selected and     %
%       set to be the new pixel value.                                    %
% ####################################################################### %

[m, n] = size(G);

% Expand G such that the resulting image will have the same size as G.
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