clc
clear all
close all

x=-pi:pi/10:2*pi;
y=sin(x);

figure;
stem(x,y)
xlabel('x');
ylabel('y');
title(' y = sin(x) ');

%% d= 2

I=imread('cameraman.tif');
figure;
imshow(I);