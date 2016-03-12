function G_noise = addSaltPepperNoise(G, p)
% ####################################################################### %
% addSaltPepperNoise: Add salt and pepper noise to the given 2D image     %
%                     matrix                                              %
%                                                                         %
%   Usage:                                                                %
%       G_noise = addSaltPepperNoise(G, p)                                %
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
%       When p is small, the resulting image tends to be similar with     %
%       the clean image; as p grows larger, the outcome becomes noisier.  %
%                                                                         %
%   Reference:                                                            %
%       http://cv2.csie.ntu.edu.tw/CV/_private/chapter7.pdf               %
% ####################################################################### %

[m, n] = size(G);
G_noise = G;
for i = 1:m
    for j = 1:n
       tmp = unifrnd(0, 1);
       if tmp < p
           G_noise(i, j) = 0;
       elseif tmp > 1 - p
           G_noise(i, j) = 255;
       end
    end
end