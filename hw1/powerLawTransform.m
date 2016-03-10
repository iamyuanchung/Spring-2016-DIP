function PLT = powerLawTransform(G, p)
% ####################################################################### %
% powerLawTransform: Perform power-law transform on the given 2D image    %
%                    matrix                                               %
%                                                                         %
%   Usage:                                                                %
%       PLT = powerLawTransform(G)                                        %
%                                                                         %
%   Description:                                                          %
%       For a given 2D image matrix G, power-law transform enhances it by %
%                                                                         %
%                          PLT = c * G^p,                                 %
%                                                                         %
%       where c is the scaling constant that is chosen to ensure the      %
%       maximum output value in PLT is 255, and p > 0 is the assigned     %
%       p-th power. For here, c = 255 / R^p, where R denotes the maximum  %
%       pixel value in G.                                                 %
%                                                                         %
% ####################################################################### %

% Scale the pixel values in G to range [0, 1]
G = G / 255;

PLT = round(255 / max(max(G))^p * G.^p);