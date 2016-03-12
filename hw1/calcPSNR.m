function PSNR = calcPSNR(G1, G2)
% ####################################################################### %
% calcPSNR: Compute the peak signal-to-noise ratio between two given      %
%           image matrix                                                  %
%                                                                         %
%   Usage:                                                                %
%       PSNE = calcPSNR(G1, G2)                                           %
%                                                                         %
%   Reference:                                                            %
%       Course slide of lecture 2.                                        %
% ####################################################################### %

% To make sure G1 and G2 have same shapes
[m1, n1] = size(G1);
[m2, n2] = size(G2);
assert(m1 == n1 && m2 == n2);

MSE = sum(sum((G1 - G2) .^ 2)) / (m1 * n1);
PSNR = 10 * log10(255 ^ 2 / MSE);