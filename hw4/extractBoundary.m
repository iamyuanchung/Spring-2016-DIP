function G = extractBoundary(F)


H = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 0; 0, 1; 1, -1; 1, 0; 1, 1];
G = F - erodeImage(F, H);