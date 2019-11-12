clc
clear all
close all

% deltaT=0.01;
% t=0:deltaT:5;
% 
% f=5;
% x1=sin(2*pi*f*t);
% figure;
% plot(t,x1)
% ylim([-2 2])
% xlabel('time')
% title('5 Hz')
% 
% f=10;
% x2=sin(2*pi*f*t);
% figure;
% plot(t,x2)
% ylim([-2 2])
% xlabel('time')
% title('10 Hz')
% 
% f=7;
% x3=sin(2*pi*f*t);
% figure;
% plot(t,x3)
% ylim([-2 2])
% xlabel('time')
% title('7 Hz')
% 
% tot = x1+x2+x3;
% figure;
% plot(t,tot)
% 
% Fs=1/deltaT;
% L=length(t);
% % Y = fft(tot);
% n=0:L-1;
% for k=0:L-1
%     Y(k+1)=sum(tot.*exp(-1i*2*pi*k*n/L));
% end
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% 
% f = Fs*(0:(L/2))/L;
% figure;
% plot(f,P1) 
% % ylim([-2 2])
% xlabel('frequency')
% 
% % totNew = ifft(Y);
% k=0:L-1;
% for n=0:L-1
%     totNew(n+1)=(1/L)*sum(Y.*exp(1i*2*pi*k*n/L));
% end
% figure;
% plot(t,totNew)

%% FFT of zebra image

% I = im2double(rgb2gray(imread('zebra.png')));
% % I = imgaussfilt(I,0.6);
% figure;
% imshow(I);
% fftOut = log(abs(fft2(I)));
% fftOut=mat2gray(fftOut);
% figure;
% histogram(fftOut)
% beta=mean(fftOut(:));
% alpha=std(fftOut(:));
% fftOut=1./(1+ exp((-fftOut+beta)./alpha) );
% figure;
% imshow(fftOut);

% H = im2double(rgb2gray(imread('K1.png')));
% H=imresize(H,size(fftOut));
% H(H<0.05)=0;
% H(H>=0.05)=1;
% se = strel('diamond',201);
% H=imerode(H,se);
% newH=zeros(size(H));
% newH(H==0)=1;
% % H=imclose(H,se);
%% Supressing horizontal frequencies

% H=ones(size(fftOut));
% H(40:end-40,:)=0;
% figure;
% imshow(H.*fftOut);
% 
% newImage=abs(ifft2(fft2(I).*H));
% figure;
% imshow(newImage);

%% Supressing vertical frequencies

% H=ones(size(fftOut));
% H(:,40:end-40)=0;
% figure;
% imshow(H.*fftOut);
% 
% newImage=abs(ifft2(fft2(I).*H));
% figure;
% imshow(newImage);

%% visualizing horizontal high frequencies

% x = column index i.e., changes horizontally
x=repmat(1:512,[512 1]);
y=repmat((1:512)',[1 512]);
u=-10;v=10;
z=sin(2*pi*u*x/512+2*pi*v*y/512);
figure;
imshow(z);
figure;
magFFT = abs(fftshift(fft2(z))); 
magFFT=mat2gray(magFFT);
se = strel('disk',3);
magFFT = imdilate(magFFT,se);
imshow(magFFT);

%% visualizing vertical high frequencies

% % x = column index i.e., changes horizontally
% x=repmat(1:512,[512 1]);
% y=repmat((1:512)',[1 512]);
% u=0;v=14;
% z=sin(2*pi*u*x/512+2*pi*v*y/512);
% figure;
% imshow(z);
% figure;
% magFFT = abs(fftshift(fft2(z))); 
% magFFT=mat2gray(magFFT);
% se = strel('disk',3);
% magFFT = imdilate(magFFT,se);
% imshow(magFFT);

%%
% z=sin(2*pi*u*x/512+2*pi*v*y/512) + sin(2*pi*u*5*x/512+2*pi*v*y/512);
% figure;
% imshow(z);
% figure;
% magFFT = abs(fftshift(fft2(z))); 
% magFFT=mat2gray(magFFT);
% se = strel('disk',3);
% magFFT = imdilate(magFFT,se);
% imshow(magFFT);
