% ####################################################################### %
% ####################################################################### %
% DIP Homework Assignment #1                                              %
% March 15, 2016                                                          %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% email: iamyuanchung@gmail.com                                           %
%                                                                         %
% Note: All of the following functions are flexible and are not limited   %
%       to handle only the required images. You can change to other       %
%       raw image files whenver you want.                                 %
% ####################################################################### %
% ####################################################################### %


% ####################################################################### %
% ##################### Warm-Up: Simple Manipulation #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Flip image I (sample1.raw) vertically.                %
% M-file name: flipVertical.m                                             %
% Usage: flipVertical(filename)                                           %
% Output image: filename.vertical.raw                                     %
% ####################################################################### %

% Specify the name of the image file to flip here.
filename = 'sample1.raw';
flipVertical(filename);
% Uncomment the following line to see the resulting image.
% imshow(readraw(strcat(filename(1, 1:length(filename) - 3), '.vertical.raw')), [0, 255]);

% ####################################################################### %
% Implementation 2: Flip image I (sample1.raw) horizontally.              %
% M-file name: flipHorizontal.m                                           %
% Usage: flipHorizontal(filename)                                         %
% Output image: filename.horizontal.raw                                   %
% ####################################################################### %

filename = 'sample1.raw';
flipHorizontal(filename);
% imshow(readraw(strcat(filename(1, 1:length(filename) - 3), '.horizontal.raw')), [0, 255]);


% ####################################################################### %
% ##################### Problem 1: Image Enhancement #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Plot the histograms of I (sample1.raw)                %
%                   and D (sample2.raw).                                  %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(filename)                                          %
% Output image: filename.histogram.png                                    %
% ####################################################################### %

filename = 'sample1.raw';
plotHistogram(filename);

filename = 'sample2.raw';
plotHistogram(filename);