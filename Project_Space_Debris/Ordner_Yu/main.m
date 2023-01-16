%% Init
clearvars;close all;clc
load('rhocoe.mat')
options = odeset('RelTol',1e-15,'AbsTol',1e-15);
warning('off')

%% Some settings
% Anfangswert (later as function argument)
GM = 3.9865005*10^14;   % m^3/s^2
R = 6378137;
h = 225e3;              % meter
h = 450e3;

mass = 140;             % kg
area = 25;              % m^2
AdM = area/mass;

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
intergral_t = 0:60:24*3600; % integral time

%% intergral and add earth rotation
[T1, Y1] = ode45(@(t,y)odefun_noforce(t,y,AdM), intergral_t, r0, options);
[T2, Y2] = ode45(@(t,y)odefun_harrispierce(t,y,AdM,dc), intergral_t, r0, options);
[T3, Y3] = ode45(@(t,y)odefun_msis(t,y,AdM), intergral_t, r0, options);

Y1e = zeros(length(T1),3);
theta_gr = 2 * pi / (24 * 3600) * T1;
for i = 1:length(T1)
    Y1e(i,:) = R3(theta_gr(i)) * Y1(i, 1:3)';
end

Y2e = zeros(length(T2),3);
theta_gr = 2 * pi / (24 * 3600) * T2;
for i = 1:length(T2)
    Y2e(i,:) = R3(theta_gr(i)) * Y2(i, 1:3)';
end

Y3e = zeros(length(T3),3);
theta_gr = 2 * pi / (24 * 3600) * T3;
for i = 1:length(T3)
    Y3e(i,:) = R3(theta_gr(i)) * Y3(i, 1:3)';
end

% Kepler Elemente 1
l1 = length(Y1);
I_Gk1 = zeros(l1,1);
Omega_Gk1 = zeros(l1,1);
w_Gk1 = zeros(l1,1);
M_Gk1 = zeros(l1,1);
e_Gk1 = zeros(l1,1);
a_Gk1 = zeros(l1,1);
E_Gk1 = zeros(l1,1);
n = zeros(l1,1);
nu = zeros(l1,1);
for i=1:length(Y1)
    [I_Gk1(i),Omega_Gk1(i),w_Gk1(i),M_Gk1(i),e_Gk1(i),a_Gk1(i)] = cart2kep(Y1(i,1:3)',Y1(i,4:6)',GM);
end

% Kepler Elemente 2
l2 = length(Y2);
I_Gk2 = zeros(l2,1);
Omega_Gk2 = zeros(l2,1);
w_Gk2 = zeros(l2,1);
M_Gk2 = zeros(l2,1);
e_Gk2 = zeros(l2,1);
a_Gk2 = zeros(l2,1);
E_Gk2 = zeros(l2,1);
n2 = zeros(l2,1);
nu2 = zeros(l2,1);
for i=1:length(Y1)
    [I_Gk2(i),Omega_Gk2(i),w_Gk2(i),M_Gk2(i),e_Gk2(i),a_Gk2(i)] = cart2kep(Y2(i,1:3)',Y2(i,4:6)',GM);
end

% Kepler Elemente 3
l3 = length(Y3);
I_Gk3 = zeros(l3,1);
Omega_Gk3 = zeros(l3,1);
w_Gk3 = zeros(l3,1);
M_Gk3 = zeros(l3,1);
e_Gk3 = zeros(l3,1);
a_Gk3 = zeros(l3,1);
E_Gk3 = zeros(l3,1);
n3 = zeros(l3,1);
nu3 = zeros(l3,1);
for i=1:length(Y3)
    [I_Gk3(i),Omega_Gk3(i),w_Gk3(i),M_Gk3(i),e_Gk3(i),a_Gk3(i)] = cart2kep(Y3(i,1:3)',Y3(i,4:6)',GM);
end



figure
plot(T1,a_Gk1)
figure
plot(T2,a_Gk2)
figure
plot(T3,a_Gk3)