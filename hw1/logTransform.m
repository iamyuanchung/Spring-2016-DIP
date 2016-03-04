function LT = logTransform(G, c)
    % TODO
    % Reference: http://arxiv.org/pdf/1003.4053.pdf
    % scale the pixel value to range [0, 1]
    G = G / 255;
    LT = round(c * log2(1 + G) * 255);
end