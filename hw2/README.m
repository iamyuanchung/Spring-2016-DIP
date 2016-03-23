% ####################################################################### %
% ###################### DIP Homework Assignment #2 ##################### %
% ####################################################################### %
% Submission Date: April 12, 2016                                         %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m
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

% create a directory called 'rslt_images' and all the output .png figures
% will be stored under it
mkdir('./', 'rslt_images');

% do not display figures during execution
fig = figure;
set(fig, 'Visible', 'off');

% ####################################################################### %
% ###################### Problem 1: Edge Detection ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Perform Sobel edge detection on S1, S2, and S3        %
% M-file name: sobelEdgeDetection.m                                       %
% Usage: EM1 = sobelEdgeDetection(S1)                                     %
%        EM2 = sobelEdgeDetection(S2)                                     %
%        EM3 = sobelEdgeDetection(S3)                                     %
% Output: The resultant edge map(EM)                                      %
% ####################################################################### %

fprintf('\nPerforming Sobel edge detection on sample1.raw and the resultant edge map will be stored as sample1.sobel.png ...\n');
EM1 = sobelEdgeDetection(S1);
imwrite(uint8(EM1), './rslt_images/sample1.sobel.png');

fprintf('\nPerforming Sobel edge detection on sample2.raw and the resultant edge map will be stored as sample2.sobel.png ...\n');
EM2 = sobelEdgeDetection(S2);
imwrite(uint8(EM2), './rslt_images/sample2.sobel.png');

fprintf('\nPerforming Sobel edge detection on sample3.raw and the resultant edge map will be stored as sample3.sobel.png ...\n');
EM3 = sobelEdgeDetection(S3);
imwrite(uint8(EM3), './rslt_images/sample3.sobel.png');


% ####################################################################### %
% ################# Problem 2: Geometrical Modification ################# %
% ####################################################################### %
% ####################################################################### %
% Implementation 1:
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