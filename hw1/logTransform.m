function LT = logTransform(G)
% ####################################################################### %
% logTransform: Perform log transform on the given 2D image matrix        %
%                                                                         %
%   Usage:                                                                %
%       LT = logTransform(G)                                              %
%                                                                         %
%   Description:                                                          %
%       For a given 2D image matrix G, log transform enhances it by       %
%                                                                         %
%                           LT = c * log(1 + G),                          %
%                                                                         %
%       where c is the scaling constant that is chosen to ensure the      %
%       maximum output value in LT is 255. For here,                      %
%       c = 255 / log(1 + R), where R denotes the maximum pixel value     %
%       in G.                                                             %
%                                                                         %
%   Reference:                                                            %
%       Reference: http://homepages.inf.ed.ac.uk/rbf/HIPR2/pixlog.htm     %
% ####################################################################### %

% Scale the pixel values in G to range [0, 1]
G = G / 255;

LT = round(255 / log(1 + max(max(G))) * log(1 + G));