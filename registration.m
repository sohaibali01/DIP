clc
clear all
close all

%% simple gradient descent

x=-1:0.1:5;
y=(x-2).^2;

figure;
plot(x,y);

I=im2double(imread('cameraman.tif'));
I=I(1:end,1:end-5);
[rows, cols]=size(I);
X=repmat((1:rows)',[1 cols]);
Y=repmat(1:cols,[rows 1]);

%% sample rotation around center

theta=pi/8;
XNew=zeros(size(X));
YNew=zeros(size(Y));
T3=[1 0  rows/2; 0 1  cols/2; 0 0 1];
T1=[1 0 -rows/2; 0 1 -cols/2; 0 0 1];
for r=1:rows
    for c=1:cols
        T2=[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
        NewCoords = (T3*T2*T1)*[X(r,c); Y(r,c); 1];
        XNew(r,c)=NewCoords(1); YNew(r,c)=NewCoords(2);
    end
end
INew=griddata(XNew,YNew,I,X,Y);
INew(isnan(INew))=0;
figure;
imshow(I)
figure;
imshow(INew);

%% registration to find theta
dT_dTheta_X=zeros(size(X));
dT_dTheta_Y=zeros(size(X));
dI_dTheta=zeros(size(X));
fix=imgaussfilt(I,2);
moving=imgaussfilt(INew,2);
newTheta = -pi/50;
maxIterations=100;
stepSize=0.1;
numPixels=length(moving(:)~=0);
currentSSIM=sum(sum((fix(moving~=0)-moving(moving~=0)).^2))./numPixels;
for i=1:maxIterations 
    T2=[cos(newTheta) -sin(newTheta) 0; sin(newTheta) cos(newTheta) 0; 0 0 1];
    totalTx=(T3*T2*T1);
    dT2=[-sin(newTheta) -cos(newTheta) 0; cos(newTheta) -sin(newTheta) 0; 0 0 1];
    dtotalTx=(T3*dT2*T1);
    for r=1:rows
        for c=1:cols
            NewCoords = totalTx*[X(r,c); Y(r,c); 1];
            XNew(r,c)=NewCoords(1); 
            YNew(r,c)=NewCoords(2);
            dNewCoords=dtotalTx*[X(r,c); Y(r,c); 1];
            dT_dTheta_X(r,c)=dNewCoords(1); 
            dT_dTheta_Y(r,c)=dNewCoords(2);
        end
    end
    movingTx=griddata(XNew,YNew,moving,X,Y);
    movingTx(isnan(movingTx))=0;
    figure;
    imshow(movingTx);
    dxMoving = diff(movingTx,1,1);
    dxMoving=[dxMoving; zeros([1 size(dxMoving,2)])];
    dyMoving = diff(movingTx,1,2);
    dyMoving = [dyMoving zeros([size(dyMoving,1) 1])];
    for r=1:rows
        for c=1:cols
            dI_dTheta(r,c) = dxMoving(r,c)*dT_dTheta_X(r,c) + dyMoving(r,c)*dT_dTheta_Y(r,c);
        end
    end
    dE_dTheta=2*(fix-movingTx).*dI_dTheta;
    numPixels=length(movingTx(:)~=0);
    SSIMNew=sum(sum((fix(movingTx~=0)-movingTx(movingTx~=0)).^2))./numPixels;
    if SSIMNew>currentSSIM
        stepSize=0.8*stepSize;
%     else
    end
    newTheta = newTheta - stepSize*sum(sum(dE_dTheta(movingTx~=0)))./numPixels;
    currentSSIM = SSIMNew;
    if stepSize<0.01
        break
    end
end
% compare newTheta with theta