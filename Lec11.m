clc
clear all
close all


hBar=(1/2)*[1 1];
gBar=(1/2)*[1 -1];
h=2*hBar;
g=-2*gBar;


%% 1D
f=[9 7 3 5 6 10 2 6];
% f=f./sum(f(:));
appx=imfilter(f,hBar,'same');
appx=appx(1:2:end);
detail=imfilter(f,gBar,'same');
detail=detail(1:2:end);

appx=upsample(appx,2);
appx=imfilter(appx,h,'same');
detail=upsample(detail,2);
detail=imfilter(detail,g,'same');
fHat=appx+detail;

%% 2D
I = im2double(imread('cameraman.tif'));
figure;
imshow(I);
% I=[1 2 3 4; 5 6 7 8; 9 0 1 2; 3 4 5 6]
%% decomposition or analysis
hBarDown=imfilter(I,hBar','same');
hBarDown=hBarDown(1:2:end,:);
C=imfilter(hBarDown,hBar,'same');
C=C(:,1:2:end);
dLH=imfilter(hBarDown,gBar,'same');
dLH=dLH(:,1:2:end);

gBarDown=imfilter(I,gBar','same');
gBarDown=gBarDown(1:2:end,:);
dHL=imfilter(gBarDown,hBar,'same');
dHL=dHL(:,1:2:end);
dHH=imfilter(gBarDown,gBar,'same');
dHH=dHH(:,1:2:end);

%% reconstruction or synthesis

CUpSample=upsample(C',2)';
CUpSampleH=imfilter(CUpSample,h,'same');
dLHUpSample=upsample(dLH',2)';
dLHUpSampleG=imfilter(dLHUpSample,g,'same');
R1=CUpSampleH+dLHUpSampleG;
R1=upsample(R1,2);
R1H=imfilter(R1,h','same');


dHLUpSample=upsample(dHL',2)';
dHLUpSampleH=imfilter(dHLUpSample,h,'same');
dHHUpSample=upsample(dHH',2)';
dHHUpSampleG=imfilter(dHHUpSample,g,'same');
R2=dHLUpSampleH+dHHUpSampleG;
R2=upsample(R2,2);
R2G=imfilter(R2,g','same');
out=R1H+R2G;
figure;
imshow(out);
