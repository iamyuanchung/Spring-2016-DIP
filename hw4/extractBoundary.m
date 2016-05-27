function G = extractBoundary(F)
% Reference: DIP_Lecture04_2016_Spring.pdf p.40


H = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 0; 0, 1; 1, -1; 1, 0; 1, 1];
G = F - erodeImage(F, H);