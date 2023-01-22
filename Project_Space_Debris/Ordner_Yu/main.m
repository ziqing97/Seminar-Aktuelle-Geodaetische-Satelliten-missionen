%% init
clc;close all;clearvars

%%
R = 6378137;            % meter
h = 225e3;              % meter
mass = 140;             % kg
area = 25;              % m^2
AdM = area/mass;

% To Kepler Elements
a = R + h;              % meter
I = deg2rad(96.6);      % radiant
e = 0.01;
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant

GM = 3.9865005e14;   % m^3/s^2
T = sqrt((a^3 * 4* pi) / (GM)); % s


%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');
tspan = 0:300; % integral time


[result_noforce,result_harris_priester,result_msis] = ...
orbit_integral(a,e,I,Omega,w,M,AdM,starttime,tspan);

%%
figure
hold on
plot(tspan,result_noforce(:,1)-R)
plot(tspan,result_harris_priester(:,1)-R)
% plot(tspan,result_msis(:,1)-R)
set(gca,'FontSize',20)


% figure
% plot(T1/3600,(a_Gk1-6378137)/1000)
% title('no air drag')
% xlabel('time [hour]')
% ylabel('height [km]')
% pbaspect([3,1,1])
% set(gca,'FontSize',32)
% set(gca,'yticklabel',get(gca,'ytick'));
% 
% figure
% plot(T2/3600,(a_Gk2-6378137)/1000)
% title('harris priest model')
% xlabel('time [hour]')
% ylabel('height [km]')
% pbaspect([3,1,1])

% 
% figure
% plot(T3/3600,(a_Gk3-6378137)/1000)
% title('msis model')
% xlabel('time [hour]')
% ylabel('height [km]')
% pbaspect([3,1,1])
% set(gca,'FontSize',32)
% set(gca,'yticklabel',get(gca,'ytick'));