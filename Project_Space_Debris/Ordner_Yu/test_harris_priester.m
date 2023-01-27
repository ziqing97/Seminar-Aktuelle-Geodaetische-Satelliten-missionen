%% init
clc;close all;clearvars

%%
R = 6378137;            % meter
h = 1000e3;              % meter
mass = 1250;             % kg
area = 5;              % m^2
AdM = area/mass;

% To Kepler Elements
a = R + h;                   % meter
I = deg2rad(98.622);         % radiant
e = 0.1;
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant

GM = 3.9865005e14;              % m^3/s^2
T = sqrt((a^3 * 4* pi) / (GM)); % s

%%
starttime = datetime(2023,1,1,0,0,0,'TimeZone','UTC');
tspan = 0:24*3600:24*3600*365*30; % integral time
figure
hold on
for i=1:length(tspan)-1
    tspan_split=[tspan(i),tspan(i+1)];
    t0 = starttime+tspan(i)/3600/24;
    if i==1
    result_harris_priester = orbit_integral(a,e,I,Omega,...
        w,M,AdM,t0,tspan_split,"hp");
    plot(result_harris_priester(:,1),result_harris_priester(:,2)-6378137)
    else
    % harris-priester model
    a = result_harris_priester(end,2);      % meter
    e = result_harris_priester(end,3);      % radiant
    I = result_harris_priester(end,4);
    Omega = result_harris_priester(end,5);   % radiant
    w = result_harris_priester(end,6);       % radiant
    M = result_harris_priester(end,7);       % radiant
    if (a-a*e)<6378137+250e3
        break
    end
    result_harris_priester = orbit_integral(a,e,I,Omega,...
        w,M,AdM,t0,tspan_split,"hp");
    plot(result_harris_priester(:,1),result_harris_priester(:,2)-6378137)
    end
    name2 = ['E:/orbit/result_hp_',num2str(i),'.mat'];
    save(name2,'result_harris_priester')

end


