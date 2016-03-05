function LHE = localHistEqual(G)
% ####################################################################### %
% localHistEqual: Perform local histogram equalization on the given 2D    %
%                 image matrix                                            %
%                                                                         %
%   Usage:                                                                %
%       LHE = localHistEqual(G)                                           %
%                                                                         %
%   Description:                                                          %
%       Similar to histEqual(G), localHistEqual(G) tries to balance the   %
%       pixel value distribution of G, whose histogram originally tends   %
%       to be imbalanced. The detail of the algorithm is discussed in     %
%       the report.                                                       %
%                                                                         %
%   Reference:                                                            %
%       http://goo.gl/vgkdcc                                              %
% ####################################################################### %

[m, n] = size(G);
G_new = zeros(m + 2, n + 2);

G_new(2:end - 1, 2:end - 1) = G;
[m_new, n_new] = size(G_new);

LHE = zeros(m, n);
for i = 1:m_new - 2
    for j = 1:n_new - 2
        HE = histEqual(G_new(i:i + 2, j:j + 2));
        LHE(i, j) = HE(2, 2);
    end
end