% ####################################################################### %
% ###################### DIP Homework Assignment #1 ##################### %
% ####################################################################### %
% Submission Date: March 15, 2016                                         %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m          2. flipVertical.m      3. flipHorizontal.m  %
%        4. plotHistogram.m   5. histEqual.m         6. localHistEqual.m  %  
%        7. logTransform.m    8. invLogTransform.m                        %
%        9. powerLawTransform.m         10. addGaussianNoise.m            %
%       11. addSaltPepperNoise.m        12. calcPSNR.m                    %
%       13. lowPassFilter.m             14. outlierDetection.m            %
%       15. myMedianFilter.m                                              %
% ####################################################################### %
% ####################################################################### %
% Remark: Please place the four input images (sample1~4.raw) and the      %
%         source code under the same directory.                           %
%         During the execution of this script, all of the required        %
%         outputs, including images and histograms, are saved as PNG      %
%         files under the same directory, and are also included in        %
%         the report. More details are stated in each function file.      %
% ####################################################################### %
% ####################################################################### %

% Load the raw images for later usage ...
I = readraw('./sample1.raw');
D = readraw('./sample2.raw');

imwrite(uint8(I), 'sample1.png');
imwrite(uint8(D), 'sample2.png');

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

% fprintf('\nFlipping image I vertically ...\n');
% imwrite(uint8(flipVertical(I)), 'sample1.vertical.png');

% ####################################################################### %
% Implementation 2: Flip image I horizontally.                            %
% M-file name: flipHorizontal.m                                           %
% Usage: flipHorizontal(I)                                                %
% Output: The horizontally flipped 2D matrix                              %
% ####################################################################### %

% fprintf('\nFlipping image I horizontally ...\n');
% imwrite(uint8(flipHorizontal(I)), 'sample1.horizontal.png');


% ####################################################################### %
% ##################### Problem 1: Image Enhancement #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Plot the histogram of I.                              %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(I)                                                 %
% Output: The 1D array that stores the distribution of pixel values       %
% ####################################################################### %

% fprintf('\nPlotting the histogram of image I ...\n');
% saveas(bar(0:255, plotHistogram(I)), 'sample1.hist.png');

% ####################################################################### %
% Implementation 2: Plot the histogram of D.                              %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(D)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

% fprintf('\nPlotting the histogram of image D ...\n');
% saveas(bar(0:255, plotHistogram(D)), 'sample2.hist.png');

% ####################################################################### %
% Implementation 3: Perform histogram equalization on D and output the    %
%                   result as H.                                          %
% M-file name: histoEqual.m                                               %
% Usage: histoEqual(D)                                                    %
% Output: the histogram equalized 2D matrix                               %
% ####################################################################### %

% fprintf('\nPerforming histogram equalization on D ...\n');
% H = histEqual(D);
% imwrite(uint8(H), 'sample2.hist.equal.png');

% ####################################################################### %
% Implementation 4: Perform local histogram equalization on D and output  %
%                   the result as L.                                      %
% M-file name: localHistEqual.m                                           %
% Usage: localHistEqual(D)                                                %
% Output: the locally equalized 2D matrix                                 %
% ####################################################################### %

% fprintf('\nPerforming local histogram equalization on D ...\n');
% L = localHistEqual(D);
% imwrite(uint8(L), 'sample2.local.hist.equal.png');

% ####################################################################### %
% Implementation 5: Plot the histogram of H.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(H)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

% fprintf('\nPlotting the histogram of H ...\n');
% saveas(bar(0:255, plotHistogram(H)), 'sample2.hist.equal.hist.png');

% ####################################################################### %
% Implementation 6: Plot the histogram of L.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(L)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

% fprintf('\nPlotting the histogram of L ...\n');
% saveas(bar(0:255, plotHistogram(L)), 'sample2.local.hist.equal.hist.png');

% ####################################################################### %
% Implementation 7: Perform the log transform on D and output the         %
%                   corresponding histogram.                              %
% M-file name: logTransform.m                                             %
% Usage: logTransform(D)                                                  %
% Output: The 2D matrix enhanced by log transform                         %
% ####################################################################### %

% fprintf('\nPerforming log transform on D and plot the corresponding histogram ...\n');
% LT = logTransform(D);
% imwrite(uint8(LT), 'sample2.log.png');
% 
% saveas(bar(0:255, plotHistogram(LT)), 'sample2.log.hist.png');

% ####################################################################### %
% Implementation 8: Perform the inverse log transform on D and output     %
%                   the corresponding histogram                           %
% M-file name: invLogTransform.m                                          %
% Usage: invLogTransform(D)                                               %
% Output: The 2D matrix enhanced by inverse log transform                 %
% ####################################################################### %

% fprintf('\nPerforming inverse log transform on D and plot the corresponding histogram ...\n');
% ILT = invLogTransform(D);
% imwrite(uint8(ILT), 'sample.inv.log.png');
% 
% saveas(bar(0:255, plotHistogram(ILT)), 'sample2.inv.log.hist.png');

% ####################################################################### %
% Implementation 9: Perform the power-law transform on D and output the   %
%                   corresponding histogram.                              %
% M-file name: powerLawTransform.m                                        %
% Usage: powerLawTransform(D, p)                                          %
% Output: The 2D matrix enhanced by power-law trnasform                   %
% ####################################################################### %

% fprintf('\nPerforming power-law transform on D and plot the corresponding histogram ...\n');
% PLT = powerLawTransform(D, 0.5);
% imwrite(uint8(PLT), 'sample2.power.law.png');
% 
% saveas(bar(0:255, plotHistogram(PLT)), 'sample.power.law.hist.png');


% ####################################################################### %
% ####################### Problem 2: Noise Removal ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Add the same noise as sample3.raw to image I          %
%                   (sample1.raw) and denote the result as N1             %
% M-file name: addSaltPepper.m                                            %
% Usage: addSaltPepper(I, p)                                              %
% Output: The 2D matrix with salt and pepper noise added                  %
% ####################################################################### %

% fprintf('\nAdding Salt and Pepper noise to I ...\n');
% N1 = addSaltPepperNoise(I, 0.005);
% imwrite(uint8(N1), 'sample1.salt.pepper.png');

% ####################################################################### %
% Implementation 2: Add the same noise as sample4.raw to image I          %
%                   (sample1.raw) and denote the result as N2             %
% M-file name: addGaussian.m                                              %
% Usage: addGaussian(I, mu, sigma, amplitude)                             %
% Output: The 2D matrix with Gaussian noise added                         %
% ####################################################################### %

% fprintf('\nAdding Gaussian noise to I ...\n');
% N2 = addGaussianNoise(I, 0, 1, 10);
% imwrite(uint8(N2), 'sample1.gaussian.png');

% ####################################################################### %
% Implementation 3: Choose proper filters and parameters to remove the    %
%                   noise in N1, and denote the result as R1.             %
% M-file name: outlierDetection.m                                         %
%              myMedianFilter.m                                           %
% Usage: outlierDetection(N1, epsilon)                                    %
%        myMedianFilter(N1)                                               %
% Output: The filtered 2D image matrix                                    %
% ####################################################################### %

% fprintf('\nNoise cleaning on N1 with outlier detection ...\n')
% R1_outlier = outlierDetection(N1, 60);
% imwrite(uint8(R1_outlier), 'sample1.salt.pepper.outlier.60.png');

% fprintf('\nNoise cleaning on N1 with median filter ...\n')
% R1_median = myMedianFilter(N1);
% imwrite(uint8(R1_median), 'sample1.salt.pepper.median.png');

% ####################################################################### %
% Implementation 4: Choose proper filters and parameters to remove the    %
%                   noise in N2, and denote the result as R2.             %
% M-file name: lowPassFilter.m                                            %
% Usage: lowPassFilter(N2, b)                                             %
% Output: The filtered 2D image matrix                                    %
% ####################################################################### %

fprintf('\nNoise cleaning on N2 with low-pass filter ...\n')
R2 = lowPassFilter(N2, 10);
imwrite(uint8(R2), 'sample1.gaussian.low.pass.10.png');

% ####################################################################### %
% Implementation 5: Compute the PSNR value of R1.                         %
% M-file name: calcPSNR.m                                                 %
% Usage: calcPSNr(I, R1)                                                  %
% Output: The PSNR value                                                  %
% ####################################################################### %

% fprintf('\nThe PSNR value of R1_outlier = %f\n', calcPSNR(I, R1_outlier));
% fprintf('\nThe PSNR value of R1_median = %f\n', calcPSNR(I, R1_median));

% ####################################################################### %
% Implementation 6: Compute the PSNR value of R2.                         %
% M-file name: calcPSNR.m                                                 %
% Usage: calcPSNr(I, R2)                                                  %
% Output: The PSNR value                                                  %
% ####################################################################### %

fprintf('\nThe PSNR value of R2 = %f\n', calcPSNR(I, R2));