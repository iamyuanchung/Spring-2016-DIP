% ####################################################################### %
% ####################################################################### %
% DIP Homework Assignment #1                                              %
% March 15, 2016                                                          %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %

% Load the raw images for later usage
I = readraw('./src_images/sample1.raw');
D = readraw('./src_images/sample2.raw');
% G3 = readraw('./src_images/sample3.raw');
% G4 = readraw('./src_images/sample4.raw');


% ####################################################################### %
% ##################### Warm-Up: Simple Manipulation #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Flip image I (sample1.raw) vertically.                %
% M-file name: flipVertical.m                                             %
% Usage: flipVertical(I)                                                  %
% Output: The vertically flipped 2D matrix                                %
% ####################################################################### %

fprintf('\nFlipping image I vertically ...\n');
writeraw(flipVertical(I), './rsl_images/sample1.vertical.raw');
% Uncomment the following line to see the resulting image
% figure; imshow(readraw('./rsl_images/sample1.vertical.raw'), [0, 255]);

% ####################################################################### %
% Implementation 2: Flip image I (sample1.raw) horizontally.              %
% M-file name: flipHorizontal.m                                           %
% Usage: flipHorizontal(I)                                               %
% Output: The horizontally flipped 2D matrix                              %
% ####################################################################### %

fprintf('\nFlipping image I horizontally ...\n');
writeraw(flipHorizontal(I), './rsl_images/sample1.horizontal.raw');
% figure; imshow(readraw('./rsl_images/sample1.horizontal.raw'), [0, 255]);


% ####################################################################### %
% ##################### Problem 1: Image Enhancement #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Plot the histogram of I (sample1.raw).                %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(I)                                                 %
% Output: The 1D array that stores the distribution of pixel values       %
% ####################################################################### %

fprintf('\nPlotting the histogram of image I ...\n');
figure; bar(0:255, plotHistogram(I));
saveas(gcf, './rsl_images/sample1.histogram.png');

% ####################################################################### %
% Implementation 2: Plot the histogram of D (sample2.raw).                %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(D)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of image D ...\n');
figure; bar(0:255, plotHistogram(D));
saveas(gcf, './rsl_images/sample2.histogram.png');

% ####################################################################### %
% Implementation 3: Perform histogram equalization on D (sample2.raw)     %
%                   and output the result as H.                           %
% M-file name: histoEqual.m                                               %
% Usage: histoEqual(D)                                                    %
% Output: the equalized 2D matrix                                         %
% ####################################################################### %

fprintf('\nPerforming histogram equalization on D ...\n');
H = histoEqual(D);
writeraw(H, './rsl_images/sample2.histo.equal.raw');
figure; imshow(readraw('./rsl_images/sample2.histo.equal.raw'), [0, 255]);

% ####################################################################### %
% Implementation 4: Perform local histogram equalization on D             %
%                   (sample2.raw) and output the result as L.             %
% M-file name: localHistoEqual.m                                          %
% Usage: localHistoEqual(D)                                               %
% Output: the locally equalized 2D matrix                                 %
% ####################################################################### %

fprintf('\nPerforming local histogram equalization on D ...\n');
L = localHistoEqual(D);
writeraw(L, './rsl_images/sample2.local.histo.equal.raw');
figure; imshow(readraw('./rsl_images/sample2.local.histo.equal.raw'), [0, 255]);

% ####################################################################### %
% Implementation 5: Plot the histogram of H.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(H)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of H ...\n');
figure; bar(0:255, plotHistogram(H));
saveas(gcf, './rsl_images/sample2.histo.equal.histogram.png');

% ####################################################################### %
% Implementation 6: Plot the histogram of L.                              %
% M-file name: plotHistgram.m                                             %
% Usage: plotHistogram(L)                                                 %
% Output: The 1D array that stores the distribution of pixel value        %
% ####################################################################### %

fprintf('\nPlotting the histogram of L ...\n');
figure; bar(0:255, plotHistogram(L));
saveas(gcf, './rsl_images/sample2.local.histo.equal.histogram.png');

% ####################################################################### %
% Implementation 7: Perform the log transform on D and output the         %
%                   corresponding histogram.                              %
% M-file name: logTransform.m                                             %
% Usage: logTransform(D, c)                                               %
% Output: The 2D matrix enhanced by log transform                         %
% ####################################################################### %

fprintf('\n Performing log transform on D ...\n');
LT = logTransform(D, 0.8);
writeraw(LT, './rsl_images/sample2.log.raw');
figure; imshow(readraw('./rsl_images/sample2.log.raw'), [0, 255]);

fprintf('\nPlotting the histogram of sample2.log.raw ...\n');
figure; bar(0:255, plotHistogram(LT));
saveas(gcf, './rsl_images/sample2.log.histogram.png');

% ####################################################################### %
% Implementation 8: Perform the inverse log transform on D and output     %
%                   the corresponding histogram                           %
% M-file name: invLogTransform.m                                          %
% Usage: 
% Output:
% ####################################################################### %

fprintf('\n Performing inverse log transform on D ...\n');
ILT = inverselogTransform();
writeraw(ILT, './rsl_images/sample2.inv.log.raw');
figure; imshow(readraw('./rsl_images/sample2.inv.log.raw'), [0, 255]);

fprintf('\nPlotting the histogram of sample2.inv.log.raw ...\n');
figure; bar(0:255, plotHistogram(ILT));
saveas(gcf, './rsl_images/sample2.inv.log.histogram.png');

% ####################################################################### %
% Implementation 9: Perform the power-law transform on D and output the   %
%                   corresponding histogram.                              %
% M-file name: powerLawTransform.m                                        %
% Usage: powerLawTransform(D, p)                                          %
% Output: The 2D matrix enhanced by power-law trnasform                   %
% ####################################################################### %

fprintf('\n Performing power-law transform on D ...\n');
PLT = powerLawTransform(D, 0.5);
writeraw(PLT, './rsl_images/sample2.power.law.raw');
figure; imshow(readraw('./rsl_images/sample2.power.law.raw'), [0, 255]);

fprintf('\nPlotting the histogram of sample2.power.law.raw ...\n');
figure; bar(0:255, plotHistogram(PLT));
saveas(gcf, './rsl_images/sample2.power.law.histogram.png');


% ####################################################################### %
% ####################### Problem 2: Noise Removal ###################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Add the same noise as sample3.raw to image I          %
%                   (sample1.raw) and denote the result as N1             %
% M-file name: addSaltPepper.m                                            %
% Usage: addSaltPepper(I)                                                %
% Output: the 2D matrix with salt and pepper noise added                  %
% ####################################################################### %


% ####################################################################### %
% Implementation 2: Add the same noise as sample4.raw to image I          %
%                   (sample1.raw) and denote the result as N2             %
% M-file name: addGaussian.m                                              %
% Usage: addGaussian(I)                                                  %
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