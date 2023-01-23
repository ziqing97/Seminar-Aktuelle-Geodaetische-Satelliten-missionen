%% init
clc;close all;clearvars

%%
R = 6378137;            % meter
h = 811.5e3;              % meter
mass = 1250;             % kg
area = 2.2^2;              % m^2
AdM = area/mass;

% To Kepler Elements
a = R + h;              % meter
I = deg2rad(98.622);      % radiant
e = 0.0002125;
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant

GM = 3.9865005e14;   % m^3/s^2
T = sqrt((a^3 * 4* pi) / (GM)); % s


%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');
tspan = 0:30*24*3600; % integral time

[result_noforce,result_harris_priester,result_msis] = ...
orbit_integral(a,e,I,Omega,w,M,AdM,starttime,tspan);

%%
save('result_noforce.mat','result_noforce')
save('result_hp.mat','result_harris_priester')
save('result_msis.mat','result_msis')

