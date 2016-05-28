% ####################################################################### %
% ###################### DIP Homework Assignment #4 ##################### %
% ####################################################################### %
% Submission Date: May 31, 2016                                           %
% Name: ¡È∑∂¶w                                                             %
% ID #: B01902040                                                         %
% Email: iamyuanchung@gmail.com                                           %
% ####################################################################### %
% ####################################################################### %
% Files: 1. README.m                                                      %
%       ###### Problem 1 ######                                           %
%        2. shapeAnalysis.m                                               %
%        3. signSegment.m                                                 %
%       ###### Problem 2 ######                                           %
%        4. skeletonizeImage.m                                            %
%        5. extractBoundary.m                                             %
%        6. opening.m                                                     %
%        7. dilateImage.m                                                 %
%        8. erodeImage.m                                                  %
%        9. createRoundKernel.m                                           %
%       ###### Problem 3 ######                                           %
%       10. DFT.m                                                         %
%       11. idealLowPass.m                                                %
%       12. gaussianLowPass.m                                             %
%       13. invDFT.m                                                      %
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
imwrite(uint8(S1), './rslt_images/Sample1.png');
imwrite(uint8(TS), './rslt_images/TrainingSet.png')
imwrite(uint8(S2), './rslt_images/Sample2.png');
imwrite(uint8(S3), './rslt_images/Sample3.png');

% do not display figures during execution
fig = figure;
set(fig, 'Visible', 'off');


% ####################################################################### %
% ###################### Problem 1: Shape Analysis ###################### %
% ####################################################################### %

count = shapeAnalysis(S1, TS);
% Accuracy: 16/22 = 73%

% ####################################################################### %
% ################# Problem 2: Morphological Processing ################# %
% ####################################################################### %

fprintf('\n    Skeletonizing Sample2.raw ...\n');
K = skeletonizeImage(S2);
imwrite(uint8(K), './rslt_images/Sample2_skeletonized.png');

fprintf('\n    Extracting the boundary of Sample2.raw ...\n');
B = extractBoundary(S2);
imwrite(uint8(B), './rslt_images/Sample2_boundary.png');

fprintf('\n    Smoothing the boundary of Sample2.raw using opening operator ...\n');
% specify the radius of the round kernel here
radius = 12;
H = createRoundKernel(radius);
O = opening(S2, H);
imwrite(uint8(O), ['./rslt_images/Sample2_opened_radius_', num2str(radius), '.png']);

% ####################################################################### %
% ################ Problem 3: Frequency-domain Filtering ################ %
% ####################################################################### %

fprintf('\n    Transfering Sample3.raw to frequency domain by DFT ... (This is going to take approximate 20 mins.)\n');
D = DFT(S3);
D_image = abs(D);
D_image_scaled = D_image / max(max(D_image));
for i = 1:15
    D_image_scaled = log2(1 + D_image_scaled);
end
D_image_scaled = D_image_scaled * 255;
imwrite(uint8(D_image_scaled), './rslt_images/Sample3_DFT.png');

fprintf('\n    Applying ideal low-pass filter to D with D0 = 5 and 30 ...\n');
L5 = idealLowPass(D, 5);
L30 = idealLowPass(D, 30);

fprintf('\n    Applying Gaussian low-pass filter to D with D0 = 5 and 30 ...\n');
G5 = gaussianLowPass(D, 5);
G30 = gaussianLowPass(D, 30);

fprintf('\n    Transfering L5, L30, G5, and G30 back to spatial domain by Inverse DFT ...\n');
L5_inv = invDFT(L5);
L30_inv = invDFT(L30);
G5_inv = invDFT(G5);
G30_inv = invDFT(G30);