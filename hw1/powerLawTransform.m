function PLT = powerLawTransform(G, p)
    % Formula of power-law transform: r = s^p
    % Input: G - the input 2D matrix
    %        p - the parameter that controls the extent of power operation
    % scale the pixel value to range [0, 1]
    G = G / 255;
    PLT = round(G .^ p * 255);
end