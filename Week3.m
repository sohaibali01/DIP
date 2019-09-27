clc
clear all
close all

% I=imread('cameraman.tif');
% I=im2double(I);
% figure;
% imshow(I);
% figure;
% histogram(I,256);
% xlim([0 1]);

%% linear transform

% a=0.7; b=0.3;
% n=0:0.1:1;
% n2=a*n+b;
% figure;
% plot(n,n2);
% title('a=0.7, b=0.3');
% xlim([0 1]);
% xlabel('input intensities');
% ylabel('output intensities');
% ylim([0 1]);
% 
% 
% I2=a*I+b;
% figure;
% imshow(I2);
% title('a=0.7, b=0.3');
% 
% figure;
% histogram(I2,256);
% xlim([0 1]);

%% negative of an image

% a=-1; b=1;
% n=0:0.1:1;
% n2=a*n+b;
% figure;
% plot(n,n2);
% title('a=-1, b=1');
% xlim([0 1]);
% xlabel('input intensities');
% ylabel('output intensities');
% ylim([0 1]);
% 
% 
% I2=a*I+b;
% figure;
% imshow(I2);
% title('a=-1, b=1');
% 
% figure;
% histogram(I2,256);
% xlim([0 1]);

%% histogram stretching

I=imread('epdf.jpg');
I=im2double(I);
figure;
imshow(I);
figure;
histogram(I,256);
xlim([0 1]);

I2=I-min(I(:));
I2=I2./max(I2(:));
figure;
imshow(I2);
figure;
histogram(I2,256);
xlim([0 1]);

% this is also equivalent

x1=min(I(:)); y1=0;
x2=max(I(:)); y2=1;
a=(y2-y1)./(x2-x1);
b=y1-a.*x1; % from y1=a*x1+b
I2=a*I+b;
figure;
imshow(I2);
figure;
histogram(I2,256);
xlim([0 1]);

n=0:0.1:1;
n2=a*n+b;
figure;
plot(n,n2);
title('a = ?, b = ?');
xlim([0 1]);
xlabel('input intensities');
ylabel('output intensities');
ylim([0 1]);

%% inverse estimation
% f1=I(2,3);
% f2=I(5,5);
% g1=I2(2,3);
% g2=I2(5,5);
% matA=[f1 1; f2 1];
% matB=[g1; g2];
% parameters = inv(matA)*matB;  % check if these parameters are equal to a and b found in line 81, 82

%% power law transformation
% c=1;
% gamma=0.4;
% I2=c.*I.^gamma;
% figure;
% imshow(I);
% title('original')
% figure;
% imshow(I2);
% title('transformed')

%% sigmoid contrast stretching
beta=mean(I(:));
alpha=std(I(:));
I2=1./(1+ exp((-I+beta)./alpha) );
figure;
imshow(I2)
figure;
histogram(I2,256);
xlim([0 1]);

n=0:0.01:1;
n2=1./(1+ exp((-n+beta)./alpha) );;
figure;
plot(n,n2);
xlim([0 1]);
xlabel('input intensities');
ylabel('output intensities');
ylim([0 1]);


