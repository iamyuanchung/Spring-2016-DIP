function G_out = addSaltPepperNoise(G, p)
% ####################################################################### %
% addSaltPepperNoise: Add salt & pepper noise to the given 2D image       %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       G_out = addSaltPepperNoise(G, p)                                  %
%                                                                         %
%   Description:                                                          %
%       For a given 2D image matrix G, salt and pepper noise is generated %
%       and added to G, yielding G_noise, according to the following      %
%       formula:                                                          %
%                                                                         %
%                  G_noise(i, j) = 0 if uniform(0, 1) < p,                %
%                                  255 if uniform(0, 1) > 1 - p,          %
%                                  G(i, j) else.                          %
%                                                                         %
%   Reference:                                                            %
%       http://cv2.csie.ntu.edu.tw/CV/_private/chapter7.pdf               %
% ####################################################################### %

[m, n] = size(G);
G_out = G;
for i = 1:m
    for j = 1:n
       tmp = unifrnd(0, 1);
       if tmp < p
           G_out(i, j) = 0;
       elseif tmp > 1 - p
           G_out(i, j) = 255;
       end
    end
end