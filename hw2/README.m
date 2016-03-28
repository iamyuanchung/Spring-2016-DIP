% ####################################################################### %
% ###################### DIP Homework Assignment #2 ##################### %
% ####################################################################### %
% Submission Date: April 12, 2016                                         %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m                                                      %
%        2. sobelEdgeDetection.m                                          %
%        ?. cannyEdgeDetection.m
% ####################################################################### %
% This script will first create a directory called 'rslt_images' under    %
% current directory, and all the output .png figures will be stored       %
% under it.                                                               %
% ####################################################################### %

% load the raw images for later usage
% S1 denotes sample1.raw, S2 denotes sample2.raw and so on
S1 = readraw('./raw/sample1.raw');
S2 = readraw('./raw/sample2.raw');
S3 = readraw('./raw/sample3.raw');
S4 = readraw('./raw/sample4.raw');
S5 = readraw('./raw/sample5.raw');
S6 = readraw('./raw/sample6.raw');
S7 = readraw('./raw/sample7.raw');
S8 = readraw('./raw/sample8.raw');

% output S1 ~ S8 as .png images
% imwrite(uint8(S1), './rslt_images/sample1.png');
% imwrite(uint8(S2), './rslt_images/sample2.png');
% imwrite(uint8(S3), './rslt_images/sample3.png');
% imwrite(uint8(S4), './rslt_images/sample4.png');
% imwrite(uint8(S5), './rslt_images/sample5.png');
% imwrite(uint8(S6), './rslt_images/sample6.png');
% imwrite(uint8(S7), './rslt_images/sample7.png');
% imwrite(uint8(S8), './rslt_images/sample8.png');

% create a directory called 'rslt_images' and all the output .png figures
% will be stored under it
% mkdir('./', 'rslt_images');

% do not display figures during execution
% fig = figure;
% set(fig, 'Visible', 'off');


% ####################################################################### %
% ###################### Problem 1: Edge Detection ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Perform Sobel edge detection on S1, S2, and S3        %
% M-file name: sobelEdgeDetection.m                                       %
% Usage: [Gr, Gc, EM] = sobelEdgeDetection(G, T)                          %
% Output: The resultant edge map(EM)                                      %
% ####################################################################### %

% T1 = 100;
% T2 = 200;
% T3 = 150;
% 
% fprintf('\nPerforming Sobel edge detection on sample1.raw and the resultant edge map will be stored as sample1.sobel.png ...\n');
% [~, ~, EM1] = sobelEdgeDetection(S1, T1);
% imwrite(uint8(EM1), './rslt_images/sample1.sobel.png');
% 
% fprintf('\nPerforming Sobel edge detection on sample2.raw and the resultant edge map will be stored as sample2.sobel.png ...\n');
% [~, ~, EM2] = sobelEdgeDetection(S2, T2);
% imwrite(uint8(EM2), './rslt_images/sample2.sobel.png');
% 
% fprintf('\nPerforming Sobel edge detection on sample3.raw and the resultant edge map will be stored as sample3.sobel.png ...\n');
% [~, ~, EM3] = sobelEdgeDetection(S3, T3);
% imwrite(uint8(EM3), './rslt_images/sample3.sobel.png');

% ####################################################################### %
% Implementation 2: Perform Laplacian of Gaussian (LoG) on S1, S2, and S3 %
% M-file name: laplacianOfGaussian.m                                      %
% Usage: EM = laplacianOfGaussian(G, filter_size)                         %
% Output: The resultant edge map(EM)                                      %
% ####################################################################### %

% filter_size_1 = 9;
% filter_size_2 = 9;
% filter_size_3 = 9;
% 
% fprintf('\nPerforming Laplacian of Gaussian (LoG) on sample1.raw and the resultant edge map will be stored as sample1.LoG.png ...\n');
% EM1 = laplacianOfGaussian(S1, filter_size_1);
% imwrite(uint8(EM1), './rslt_images/sample1.LoG.png');
% 
% fprintf('\nPerforming Laplacian of Gaussian (LoG) on sample2.raw and the resultant edge map will be stored as sample2.LoG.png ...\n');
% EM2 = laplacianOfGaussian(S2, filter_size_2);
% imwrite(uint8(EM2), './rslt_images/sample2.LoG.png');
% 
% fprintf('\nPerforming Laplacian of Gaussian (LoG) on sample3.raw and the resultant edge map will be stored as sample3.LoG.png ...\n');
% EM3 = laplacianOfGaussian(S3, filter_size_3);
% imwrite(uint8(EM3), './rslt_images/sample3.LoG.png');

% ####################################################################### %
% Implementation 3: Perform Canny edge detection on S1, S2, and S3        %
% M-file name: cannyEdgeDetection.m                                       %
% Usage: EM = cannyEdgeDetection(G, T_high, T_low)                        %
% Output: The resultant edge map(EM)                                      %
% ####################################################################### %

% T1_low = 20;
% T1_high = 80;
% T2_low = 20;
% T2_high = 80;
% T3_low = 20;
% T3_high = 80;
% 
% fprintf('\nPerforming Canny edge detection on sample1.raw and the resultant edge map will be stored as sample1.canny.png ...\n');
% EM1 = cannyEdgeDetection(S1, T1_high, T1_low);
% imwrite(uint8(EM1), './rslt_images/sample1.canny.png');
% 
% fprintf('\nPerforming Canny edge detection on sample2.raw and the resultant edge map will be stored as sample2.canny.png ...\n');
% EM2 = cannyEdgeDetection(S2, T2_high, T2_low);
% imwrite(uint8(EM2), './rslt_images/sample2.canny.png');
% 
% 
% fprintf('\nPerforming Canny edge detection on sample3.raw and the resultant edge map will be stored as sample3.canny.png ...\n');
% EM3 = cannyEdgeDetection(S3, T3_high, T3_low);
% imwrite(uint8(EM3), './rslt_images/sample3.canny.png');


% ####################################################################### %
% ################# Problem 2: Geometrical Modification ################# %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Stitch sample4 ~ 7.raw into one complete image R and  %
%                   paint the residual regions in black. Also, crop the   %
%                   largest square in R and output it as S                %
% M-file name: stitchFourImages.m                                         %
% Usage: [R, S] = stitchFourImages(S4, S5, S6, S7)                        %
% Output: R and S, which are described as above                           %
% ####################################################################### %

% fprintf('\nStitching sample4.raw, sample5.raw, sample6.raw, and sample7.raw ...\n');
% [R, S] = stitchFourImages(S4, S5, S6, S7);
% imwrite(uint8(R), './rslt_images/sample4_5_6_7.png');
% imwrite(uint8(S), './rslt_images/sample4_5_6_7_crop.png');

% ####################################################################### %
% Implementation 2: 
% M-file name: 
% Usage: 
% Output: 
% ####################################################################### %




% ####################################################################### %
% ##################### Problem 3: Texture Analysis ##################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1:
% M-file name:
% Usage:
% Output:
% ####################################################################### %

