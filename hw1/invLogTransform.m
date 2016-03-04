function ILT = invLogTransform(G)
% ####################################################################### %
% invLogTransform: Perform inverse log transform on the given 2D          %
%                  image matrix                                           %
%                                                                         %
%   Usage:                                                                %
%       ILT = invLogTransform(G)                                          %
%                                                                         %
%   Description:                                                          %
%       For a given 2D image matrix G, inverse log transform enhances     %
%       it by                                                             %
%                                                                         %
%                          ILT = c * (exp(G) - 1),                        %
%                                                                         %
%       where c is the scaling constant that is chosen to ensure the      %
%       maximum output value in ILT is 255. For here,                     %
%       c = 255 / (exp(R) - 1), where R denotes the maximum pixel         %
%       value in G.                                                       %
%                                                                         %
% ####################################################################### %

% Scale the pixel values in G to range [0, 1]
G = G / 255;

ILT = round(255 / (exp(max(max(G))) - 1) * (exp(G) - 1));