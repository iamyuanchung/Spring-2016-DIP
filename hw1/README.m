% ####################################################################### %
% ###################### DIP Homework Assignment #1 ##################### %
% ####################################################################### %
% Deadline: March 15, 2016                                                %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m          2. flipVertical.m      3. flipHorizontal.m  %
%        4. plotHistogram.m   5. histEqual.m         6. localHistEqual.m  %  
%        7. logTransform.m    8. powerLawTransform.m                      %
%        9. invLogTransform.m                                             %
% ####################################################################### %
% ####################################################################### %
% Remark: Please place the four input images (sample1~4.raw) and the      %
%         source code under the same directory.                           %
%         During the execution of this script, all of the required        %
%         outputs, including images and histograms, are saved as PNG      %
%         files under the same directory, and are also included in        %
%         the report.                                                     %
%         For function 2 ~ 9, each of them is given a 2D matrix that      %
%         represents the digital image pixel, and returns a modified      %
%         (according to the requirement) 2D matrix.                       %
%         More details are stated in each function file.                  %
% ####################################################################### %
% ####################################################################### %

% Load the raw images for later usage ...
I = readraw('./sample1.raw');
D = readraw('./sample2.raw');

% Do not display figures during execution ...
fig = figure;
set(fig, 'Visible', 'off');

% ####################################################################### %
% ##################### Warm-Up: Simple Manipulation #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Flip image I vertically.                              %
% M-file name: flipVertical.m                                             %
% Usage: flipVertical(I)                                                  %
% Output: The vertically flipped 2D matrix                                %
% ####################################################################### %

fprintf('\nFlipping image I vertically ...\n');
imwrite(uint8(flipVertical(I)), 'sample1.vertical.png');

% ####################################################################### %
% Implementation 2: Flip image I horizontally.                            %
% M-file name: flipHorizontal.m                                           %
% Usage: flipHorizontal(I)                                                %
% Output: The horizontally flipped 2D matrix                              %
% ####################################################################### %

fprintf('\nFlipping image I horizontally ...\n');
imwrite(uint8(flipHorizontal(I)), 'sample1.horizontal.png');


% ####################################################################### %
% ##################### Problem 1: Image Enhancement #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Plot the histogram of I.                              %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(I)                                                 %
% Output: The 1D array that stores the distribution of pixel values       %
% ####################################################################### %

fprintf('\nPlotting the histogram of image I ...\n');
saveas(bar(0:255, plotHistogram(I)), 'sample1.hist.png');

% ####################################################################### %
% Implementation 2: Plot the histogram of D.                              %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(D)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of image D ...\n');
saveas(bar(0:255, plotHistogram(D)), 'sample2.hist.png');

% ####################################################################### %
% Implementation 3: Perform histogram equalization on D and output the    %
%                   result as H.                                          %
% M-file name: histoEqual.m                                               %
% Usage: histoEqual(D)                                                    %
% Output: the histogram equalized 2D matrix                               %
% ####################################################################### %

fprintf('\nPerforming histogram equalization on D ...\n');
H = histEqual(D);
imwrite(uint8(H), 'sample2.hist.equal.png');

% ####################################################################### %
% Implementation 4: Perform local histogram equalization on D and output  %
%                   the result as L.                                      %
% M-file name: localHistEqual.m                                           %
% Usage: localHistEqual(D)                                                %
% Output: the locally equalized 2D matrix                                 %
% ####################################################################### %

fprintf('\nPerforming local histogram equalization on D ...\n');
L = localHistEqual(D);
imwrite(uint8(L), 'sample2.local.hist.equal.png');

% ####################################################################### %
% Implementation 5: Plot the histogram of H.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(H)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of H ...\n');
saveas(bar(0:255, plotHistogram(H)), 'sample2.hist.equal.hist.png');

% ####################################################################### %
% Implementation 6: Plot the histogram of L.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(L)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of L ...\n');
saveas(bar(0:255, plotHistogram(L)), 'sample2.local.hist.equal.hist.png');

% ####################################################################### %
% Implementation 7: Perform the log transform on D and output the         %
%                   corresponding histogram.                              %
% M-file name: logTransform.m                                             %
% Usage: logTransform(D)                                                  %
% Output: The 2D matrix enhanced by log transform                         %
% ####################################################################### %

fprintf('\nPerforming log transform on D and plot the corresponding histogram ...\n');
LT = logTransform(D);
imwrite(uint8(LT), 'sample2.log.png');

saveas(bar(0:255, plotHistogram(LT)), 'sample2.log.hist.png');

% ####################################################################### %
% Implementation 8: Perform the inverse log transform on D and output     %
%                   the corresponding histogram                           %
% M-file name: invLogTransform.m                                          %
% Usage: invLogTransform(D)                                               %
% Output: The 2D matrix enhanced by inverse log transform                 %
% ####################################################################### %

fprintf('\nPerforming inverse log transform on D and plot the corresponding histogram ...\n');
ILT = invLogTransform(D);
imwrite(uint8(ILT), 'sample.inv.log.png');

saveas(bar(0:255, plotHistogram(ILT)), 'sample2.inv.log.hist.png');

% ####################################################################### %
% Implementation 9: Perform the power-law transform on D and output the   %
%                   corresponding histogram.                              %
% M-file name: powerLawTransform.m                                        %
% Usage: powerLawTransform(D, p)                                          %
% Output: The 2D matrix enhanced by power-law trnasform                   %
% ####################################################################### %

fprintf('\nPerforming power-law transform on D and plot the corresponding histogram ...\n');
PLT = powerLawTransform(D, 0.5);
imwrite(uint8(PLT), 'sample2.power.law.png');

saveas(bar(0:255, plotHistogram(PLT)), 'sample.power.law.hist.png');


% ####################################################################### %
% ####################### Problem 2: Noise Removal ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Add the same noise as sample3.raw to image I          %
%                   (sample1.raw) and denote the result as N1             %
% M-file name: addSaltPepper.m                                            %
% Usage: addSaltPepper(I)                                                 %
% Output: the 2D matrix with salt and pepper noise added                  %
% ####################################################################### %


% ####################################################################### %
% Implementation 2: Add the same noise as sample4.raw to image I          %
%                   (sample1.raw) and denote the result as N2             %
% M-file name: addGaussian.m                                              %
% Usage: addGaussian(I)                                                   %
% Output: the 2D matrix with Gaussian noise added                         %
% ####################################################################### %



% ####################################################################### %
% Implementation 3: Choose proper filters and parameters to remove the    %
%                   noise in N1, and denote the result as R1.             %
% M-file name: TODO                                                       %
% Usage: TODO                                                             %
% Output: TODO                                                            %
% ####################################################################### %



% ####################################################################### %
% Implementation 4: Choose proper filters and parameters to remove the    %
%                   noise in N2, and denote the result as R2.             %
% M-file name: TODO                                                       %
% Usage: TODO                                                             %
% Output: TODO                                                            %
% ####################################################################### %



% ####################################################################### %
% Implementation 5: Compute the PSNR value of R1.                         %
% M-file name: TODO                                                       %
% Usage: TODO                                                             %
% Output: TODO                                                            %
% ####################################################################### %



% ####################################################################### %
% Implementation 6: Compute the PSNR value of R2.                         %
% M-file name: TODO                                                       %
% Usage: TODO                                                             %
% Output: TODO                                                            %
% ####################################################################### %

