%%
clc;close all;clearvars
options = odeset('RelTol',1e-15,'AbsTol',1e-15);

%% Some settings
% Anfangswert (later as function argument)
GM = 3.9865005*10^14;   % m^3/s^2
R = 6378137;
h = 225e3;              % meter

a = R + h;              % meter
I = deg2rad(96.6);      % radiant
e = 0;                  % keine Einheit
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant

n = 2 * pi * sqrt(a^3 / GM);  % period in seconds

% transformation from kepler elements to 
[r,v] = kep2cart(I,Omega,w,M,e,a,GM);  % meter for r and m/s for v
r0 = [r';v'];

%%
intergral_t=[0, 8*n]; % integral time

%% intergral and add earth rotation
[T1,Y1]=ode45(@(t,y)odefun(t,y,dc),intergral_t,r11,options);
Y1e = zeros(length(T1),3);
theta_gr=2*pi/(24*3600)*T1;
for i=1:length(T1)
    Y1e(i,:)=R3(theta_gr(i))*Y1(i,1:3)';
end

figure;
[x,y,z]=ellipsoid(0,0,0,6378137,6378137,6356752.3142);
surf(x, y, z);
axis equal;
grid on;
hold on;
title('without air drag')
plot3(Y1e(:,1),Y1e(:,2),Y1e(:,3),'b','LineWidth',2);