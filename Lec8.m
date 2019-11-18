clc
clear all
close all

I(:,:,1)=zeros(500,500);
I(:,:,2)=zeros(500,500);
I(:,:,3)=zeros(500,500);

I(50:300,50:200,1)=1;
I(50:300,150:450,2)=1;
I(200:450,50:400,3)=1;

% I=im2double(imread('pic.jpg'));
figure;
imshow(I)

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;
%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));
%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);
%Normalize to the range [0 1]
H=H/360;
%Saturation
S=1- (3./(sum(I,3)+0.000001)).*min(I,[],3);
%Intensity
I=sum(I,3)./3;

figure;
imshow(H);
title('Hue')
figure;
imshow(S);
title('Saturation')
figure;
imshow(I);
title('Intensity')