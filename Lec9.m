clc
clear all
close all

 %% plane
 
 x=repmat(1:10,[10 1]);
 y=repmat((1:10)',[1 10]);
 a=0.4;
 b=0.7;
c=0;
d=3;
z=a*x+b*y+c*x.*y+d; 
figure;
surf(x,y,z)
xlabel('x')
ylabel('y')
zlabel('f(x,y)')

%% linear interpolation
x=[1 2 3 4];
y=[0.5 3 1 2];
figure
stem(x,y,'filled')
xlabel('x')
ylabel('y = f(x)')
xlim([0 5])
ylim([0 4])
% 
%% bilinear interpolation
 x=repmat(1:3,[3 1]);
 y=repmat((1:3)',[1 3]);
z=rand(size(x));
figure
stem3(x,y,z,'filled')
xlabel('x')
ylabel('y')
zlabel('z = f(x,y)')
xlim([0 4])
ylim([0 4])

A=[1 x(1,1) y(1,1) x(1,1)*y(1,1);
   1 x(1,2) y(1,2) x(1,2)*y(1,2);
   1 x(2,1) y(2,1) x(2,1)*y(2,1);
   1 x(2,2) y(2,2) x(2,2)*y(2,2)];

B=[z(1,1); z(1,2); z(2,1); z(2,2)];
coeff=inv(A)*B;


 xN=repmat(1:0.01:2,[101 1]);
 yN=repmat((1:0.01:2)',[1 101]);
 zN=coeff(1)+coeff(2)*xN+coeff(3)*yN+coeff(4)*xN.*yN;
 hold on
% figure;
plot3(xN,yN,zN);
% xlim([0 4])
% ylim([0 4])

%% 2D linear or bilinear interpolation 

A=[1 2 3; 4 5 6; 7  8 9]
x=repmat(1:3,[3 1]);
y=repmat((1:3)',[1 3]);
xNew=repmat(1:0.5:3,[5 1]);
yNew=repmat((1:0.5:3)',[1 5]);
% B=imresize(A,[5 5]);
B = interp2(x,y,A,xNew,yNew)