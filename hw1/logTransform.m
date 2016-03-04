function LT = logTransform(G, c)
    % Formula of log transform: r = c * log(1 + s), where s is the source
    % pixel value that is scaled to range [0, 1], r is the resulting pixel
    % value, and c is the parameter that controls the extent of log
    % transform.
    % Input: G - the input 2D matrix
    %        c - the parameter that controls the extend of log transform
    % Reference: http://arxiv.org/pdf/1003.4053.pdf
    G = G / 255; % scale the pixel value to range [0, 1]
    LT = round(c * log2(1 + G) * 255);
end