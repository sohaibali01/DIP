clc
clear all
close all
%% biliner interpolation
% y increases from left to right while x increases from top to bottom

I=imread('cameraman.tif');
figure
imshow(I)

[rows, cols]=size(I);
Y=repmat(1:1:cols,[rows 1]);  % x coordinates of each pixel
X=repmat((1:1:rows)',[1 cols]); % y coordinates of each pixel

%% using builtin methods
affineMat=[1 0.24 0.12; 0.15 1 0.1; 0 0 1];
tform = affine2d(affineMat');  % this is specified in transposed form in matlab compared to lectures
J = imwarp(I,tform);
figure;
imshow(J) %% youll see that image J has increased size than I. this is because the transform may increase image boundaries. 
% e.g. top left coordinate at (1,1) can move to (-10.56464, -14.35451),
% bottom right point at (256,256) may move to (350,400) etc....
title('builtin warping')
%% manual methods

% avoid loops as much as possible
Xbold=[X(:)'; Y(:)'; ones(1,rows*cols)]; % Xbold is a 2x65536 matrix containing x corrdinates in first row and y coordinates in 2nd row
UBold=inv(affineMat)*Xbold; % UBold is a 2x65536 matrix containing u corrdinates in first row and v coordinates in 2nd row
UBold=UBold(1:2,:); % delete 3rd row
U = reshape(UBold(1,:),rows,cols);  % seperate out U and V from combined vector
V = reshape(UBold(2,:),rows,cols);
out=zeros(rows,cols);
for r=1:rows
    for c=1:cols
        % fthere are some pixel lcoation that map outside image boundaries,
        % skip those....
        if (floor(U(r,c)) < 1)
            continue
        end
        if (floor(V(r,c)) < 1)
            continue
        end
        if (ceil(U(r,c)) > rows)
            continue
        end
        if (ceil(V(r,c)) > cols)
            continue
        end
        % from slide 7 of lecture 3
        A = [1 floor(U(r,c)) floor(V(r,c)) floor(U(r,c))*floor(V(r,c));
            1 floor(U(r,c)) ceil(V(r,c)) floor(U(r,c))*ceil(V(r,c));
            1 ceil(U(r,c)) floor(V(r,c)) ceil(U(r,c))*floor(V(r,c));
            1 ceil(U(r,c)) ceil(V(r,c)) ceil(U(r,c))*ceil(V(r,c))];
        B = [I(floor(U(r,c)),floor(V(r,c)));
            I(floor(U(r,c)),ceil(V(r,c)))
            I(ceil(U(r,c)),floor(V(r,c)))
            I(ceil(U(r,c)),ceil(V(r,c)))];
        par= inv(A)*double(B);  % 4x1 matrix
        out(X(r,c),Y(r,c))=[1 U(r,c) V(r,c) U(r,c)*V(r,c)]*par; 
    end
end
% out=out';
% out(out<0)=0;
% out(out>255)=255;
out=uint8(out);
figure;
imshow(out)
title('manual interpolation')
%% another builtin using forward mapping
% % interp2 assumes inverted axes
% 
% V=repmat(1:1:cols,[rows 1]);  % x coordinates of each pixel
% U=repmat((1:1:rows)',[1 cols]); % y coordinates of each pixel
% Ubold=[U(:)'; V(:)'; ones(1,rows*cols)]; % Xbold is a 2x65536 matrix containing x corrdinates in first row and y coordinates in 2nd row
% XBold=affineMat*Ubold; % UBold is a 2x65536 matrix containing u corrdinates in first row and v coordinates in 2nd row
% XBold=XBold(1:2,:); % delete 3rd row
% Y = reshape(XBold(1,:),rows,cols);  % seperate out U and V from combined vector
% X = reshape(XBold(2,:),rows,cols);
% I2 = interp2(V,U, double(I),Y,X);
% I2=uint8(I2);
% figure;
% imshow(I2)