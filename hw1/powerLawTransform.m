function PLT = powerLawTransform(G, p)
    % TODO
    % scale the pixel value to range [0, 1]
    G = G / 255;
    PLT = round(G .^ p * 255);
end