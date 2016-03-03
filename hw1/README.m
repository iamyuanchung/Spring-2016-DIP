% ####################################################################### %
% ####################################################################### %
% DIP Homework Assignment #1                                              %
% March 15, 2016                                                          %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %

% Load the raw images.
G1 = readraw('./src_images/sample1.raw');
G2 = readraw('./src_images/sample2.raw');
G3 = readraw('./src_images/sample3.raw');
G4 = readraw('./src_images/sample4.raw');

% ####################################################################### %
% ##################### Warm-Up: Simple Manipulation #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Flip image I (sample1.raw) vertically.                %
% M-file name: flipVertical.m                                             %
% Usage: flipVertical(G1)                                                 %
% Output: the flipped 2D matrix                                           %
% ####################################################################### %

% fprintf('\nFlipping sample1.raw vertically ...\n');
% G1_vertical = flipVertical(G1);
% writeraw(G1_vertical, './rsl_images/sample1.vertical.raw');
% Uncomment the following line to see the resulting image.
% imshow(readraw('./rsl_images/sample1.vertical.raw')), [0, 255]);

% ####################################################################### %
% Implementation 2: Flip image I (sample1.raw) horizontally.              %
% M-file name: flipHorizontal.m                                           %
% Usage: flipHorizontal(G1)                                               %
% Output: the flipped 2D matrix                                           %
% ####################################################################### %

% fprintf('\nFlipping sample1.raw horizontally ...\n');
% G1_horizontal = flipHorizontal(G1);
% writeraw(G1_horizontal, './rsl_images/sample1.horizontal.raw');
% imshow(readraw('./rsl_images/sample1.horizontal.raw')), [0, 255]);


% ####################################################################### %
% ##################### Problem 1: Image Enhancement #################### %
% ####################################################################### %
% ####################################################################### %
% Implementation 1: Plot the histograms of I (sample1.raw)                %
%                   and D (sample2.raw).                                  %
% M-file name: plotHistogram.m                                            %
% Usage: plotHistogram(G1)                                                %
%        plotHistogram(G2)                                                %
% Output: the 1D array that stores the distribution of pixel value        %
% ####################################################################### %

% fprintf('\nPlotting the histogram of sample1.raw\n');
% H1 = plotHistogram(G1);
% bar(0:255, H1);
% saveas(gcf, './rsl_images/sample1.histogram.png');
% 
% fprintf('\nPlotting the histogram of sample2.raw\n');
% H2 = plotHistogram(G2);
% bar(0:255, H2);
% saveas(gcf, './rsl_images/sample2.histogram.png');

% ####################################################################### %
% Implementation 2: Perform histogram equalization on D (sample2.raw)     %
%                   and output the result as H.                           %
% M-file name: histoEqual.m                                               %
% Usage: histoEqual(G2)                                                   %
% Output: the equalized 2D matrix                                         %
% ####################################################################### %

% fprintf('\nPerforming histogram equalization on sample2.raw ...\n');
% H = histoEqual(G2);
% writeraw(H, './rsl_images/sample2.histo.equal.raw');
% figure; imshow(readraw('./rsl_images/sample2.histo.equal.raw'), [0, 255]);

% ####################################################################### %
% Implementation 3: Perform local histogram equalization on D             %
%                   (sample2.raw) and output the result as L.             %
% M-file name: localHistoEqual.m                                          %
% Usage: localHistoEqual(G2)                                              %
% Output: the locally equalized 2D matrix                                 %
% ####################################################################### %

% fprintf('\nPerforming local histogram equalization on sample2.raw ...\n');
% L = localHistoEqual(G2);
% writeraw(L, './rsl_images/sample2.local.histo.equal.raw');
% figure; imshow(readraw('./rsl_images/sample2.local.histo.equal.raw'), [0, 255]);

% ####################################################################### %
% Implementation 4: Plot the histograms of H and L.                       %
% M-file name: plotHistgrams.m                                            %
% Usage: plotHistogram(H)                                                 %
%        plotHistogram(L)                                                 %
% Output: the 1D array that stores the distribution of pixel value        %
% ####################################################################### %

% fprintf('\nPlotting the histogram of sample2.histo.equal.raw\n');
% H_his = plotHistogram(H);
% bar(0:255, H_his);
% saveas(gcf, './rsl_images/sample2.histo.equal.histogram.png');
% 
% fprintf('\nPlotting the histogram of sample2.local.histo.equal.raw\n');
% L_his = plotHistogram(L);
% bar(0:255, L_his);
% saveas(gcf, './rsl_images/sample2.local.histo.equal.histogram.png');

% ####################################################################### %
% Implementation 5: Perform the log transform on D and output the         %
%                   corresponding histogram                               %
% M-file name: logTransform.m                                             %
% Usage: 
% Output:
% ####################################################################### %

% ####################################################################### %
% Implementation 6: Perform the inverse log transform on D and output     %
%                   the corresponding histogram                           %
% M-file name: invLogTransform.m                                          %
% Usage: 
% Output:
% ####################################################################### %

% ####################################################################### %
% Implementation 7: Perform the power-law transform on D and output the   %
%                   corresponding histogram                               %
% M-file name: powerLawTransform.m                                        %
% Usage: 
% Output:
% ####################################################################### %