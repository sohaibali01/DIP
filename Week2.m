clc
clear all
close all

%% sampling 

x=-pi:pi/10:2*pi;
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
stem(x,y);
hold on;
plot(x,y);
% L = multithresh(y,4);

L=[-0.75, -0.25, 0.25, 0.75];
y_hat=y;
for i=1:length(L)-1
    y_hat(y_hat>L(i)&y_hat<=L(i+1))=L(i);
end
y_hat(y_hat<L(1))=L(1);
y_hat(y_hat>L(end))=L(end);
stem(x,y_hat)
xlabel('x');
ylabel('y');
title(' MSE = 0.0587');
MSE1=(1/length(y)).*(sum((y_hat-y).^2));

L = multithresh(y,4);
y_hat=y;
for i=1:length(L)-1
    y_hat(y_hat>L(i)&y_hat<=L(i+1))=L(i);
end
y_hat(y_hat<L(1))=L(1);
y_hat(y_hat>L(end))=L(end);
figure;
stem(x,y);
hold on;
plot(x,y);
stem(x,y_hat)
xlabel('x');
ylabel('y');
title(' MSE = 0.0744');
MSE2=(1/length(y)).*(sum((y_hat-y).^2));

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
