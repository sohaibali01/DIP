clc
clear all
close all

I=imread('cameraman.tif');
figure;
imshow(I);

lpFilter=(1/9) * [1 1 1; 1 1 1; 1 1 1];
LF=imfilter(I,lpFilter,'same');

figure;
imshow(LF)
title('low pass output')

HF=I-LF;
figure;
imshow(HF)
title('I - LF')

identityFilter=[ 0 0 0; 0 1 0; 0 0 0];
hpFilter=identityFilter - lpFilter;

HFNew=imfilter(I,hpFilter,'same');

figure;
imshow(HFNew)
title('high pass output')

sharpImage = I + HF;  % or 2* I - LF from line 16
figure;
imshow(sharpImage)
title('sharp output')

gaussianFilter = fspecial('gaussian',[ 5 5],1);

logFilter = fspecial('log',[ 5 5],1);
LF=imfilter(I,gaussianFilter,'same');

%% sobel edge detection

vfilter = [1 0  -1; 2 0 -2; 1 0 -1];
hfilter = [1 0  -1; 2 0 -2; 1 0 -1]';
xHF=mat2gray(imfilter(I,hfilter,'same'));
figure;
imshow(xHF);
title('horizontal High frequencies')
yHF=mat2gray(imfilter(I,vfilter,'same'));
figure;
imshow(yHF);
title('vertical High frequencies')
gradientMagnitude = sqrt( (xHF.^2) + (yHF.^2));
figure;
imshow(gradientMagnitude);
title('gradient Magnitude')

thresholdedImage = gradientMagnitude;
thresholdedImage(thresholdedImage<0.5)=0;
thresholdedImage(thresholdedImage>=0.5)=1;
figure;
imshow(thresholdedImage);
title('thresholded Image')

gradientDirection = mat2gray(atan2(yHF,xHF));
figure;
imshow(gradientDirection);
title('gradient Direction')
