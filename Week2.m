clc
clear all
close all

%% sampling 

x=-pi:pi/20:2*pi;
y=sin(x);

figure;
plot(x,y);
hold on;
stem(x,y)
xlabel('x');
ylabel('y');
title(' y = sin(x), sampling period of pi/10');

%% quantization
figure;
plot(x,y);
hold on;
L = multithresh(y,14);

% L=[-0.75, -0.25, 0.25, 0.75];
for i=1:length(L)-1
    y(y>L(i)&y<=L(i+1))=L(i);
end
y(y<L(1))=L(1);
y(y>L(end))=L(end);

stem(x,y)
xlabel('x');
ylabel('y');
title(' y = sin(x), sampling period of pi/20, quantization of 14 levels');

%% image sampling


I=imread('cameraman.tif');
figure;
imshow(I);
title('256 X 256');
I=imresize(I,0.5);
figure;
imshow(I);
title('128 X 128');
I=imresize(I,0.5);
figure;
imshow(I);
title('64 X 64');

%% imaage quatization
I=imread('cameraman.tif');
figure;
imshow(I);
thresh = multithresh(I,4);
quant_4 = mat2gray(imquantize(I,thresh));
figure;
imshow(quant_4);
thresh = multithresh(I,2);
quant_2 = mat2gray(imquantize(I,thresh));
figure;
imshow(quant_2);
