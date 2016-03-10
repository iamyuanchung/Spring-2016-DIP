function PSNR = calcPSNR(G1, G2)
% ####################################################################### %
% calcPSNR: Compute the peak signal-to-noise ratio                        %
%                                                                         %
%   Usage:                                                                %
%       PSNE = calcPSNR(G1, G2)                                           %
%                                                                         %
%   Reference:                                                            %
%       Course slides of lecture 2.                                       %
% ####################################################################### %

[m, n] = size(G1);
MSE = sum(sum((G1 - G2) .^ 2)) / (m * n);
PSNR = 10 * log10(255 ^ 2 / MSE);