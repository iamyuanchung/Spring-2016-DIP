% ####################################################################### %
% ###################### DIP Homework Assignment #4 ##################### %
% ####################################################################### %
% Submission Date: May 31, 2016                                           %
% Name: Áé·¶¦w                                                            %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m                                                      %
%        2. 
% ####################################################################### %
% ####################################################################### %

% load the raw images for later usage
S1 = readraw('./raw/Sample1.raw');
TS = readraw('./raw/TrainingSet.raw');
S2 = readraw('./raw/Sample2.raw');
S3 = readraw('./raw/Sample3.raw');

% create a directory called 'rslt_images' and all the output .png figures
% will be stored under it
mkdir('./', 'rslt_images');

% output S1 ~ S3 and TS as .png images
% imwrite(uint8(S1), './rslt_images/Sample1.png');
% imwrite(uint8(TS), './rslt_images/TrainingSet.png')
% imwrite(uint8(S2), './rslt_images/Sample2.png');
% imwrite(uint8(S3), './rslt_images/Sample3.png');

% do not display figures during execution
fig = figure;
set(fig, 'Visible', 'off');


% ####################################################################### %
% ###################### Problem 1: Shape Analysis ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: 
% M-file name: 
% Usage: 
% Output: 
% ####################################################################### %

count = shapeAnalysis(S1, TS);
% Accuracy: 16/22 = 73%

% ####################################################################### %
% ################# Problem 2: Morphological Processing ################# %
% ####################################################################### %
% ####################################################################### %
% Implementation 2: 
% M-file name: 
% Usage: 
% Output: 
% ####################################################################### %

% fprintf('\n    Skeletonizing Sample2.raw ...\n');
% K = skeletonizeImage(S2);
% imwrite(uint8(K), './rslt_images/Sample2_skeletonized.png');
% 
% fprintf('\n    Extracting the boundary of Sample2.raw ...\n');
% B = extractBoundary(S2);
% imwrite(uint8(B), './rslt_images/Sample2_boundary.png');
% 
% fprintf('\n    Smoothing the boundary of Sample2.raw using opening operator ...\n');
%  % specify the radius of the round kernel here
% radius = 8;
% H = createRoundKernel(radius);
% O = opening(S2, H);
% imwrite(uint8(O), './rslt_images/Sample2_opened.png');

% ####################################################################### %
% ################ Problem 3: Frequency-domain Filtering ################ %
% ####################################################################### %
% ####################################################################### %
% Implementation 3: 
% M-file name: 
% Usage: 
% Output: 
% ####################################################################### %

% fprintf('\n    Transfering Sample3.raw to frequency domain by DFT ...\n');
% D = DFT(S3);
% D -> abs -> log10 -> scale to [0, 255] -> output image
% D_image = log10(abs(D));
% maxPixelValue = max(max(D_image));
% minPixelValue = min(min(D_image));
% D_image_scaled = 255 * (D_image - minPixelValue) / (maxPixelValue - minPixelValue);
% D_image_scaled = 255 * D_image / minPixelValue;
% imwrite(uint8(D_image_scaled), './rslt_images/Sample3_DFT.png');