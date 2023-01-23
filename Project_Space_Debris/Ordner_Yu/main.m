%% init
clc;close all;clearvars

%%
R = 6378137;            % meter
h = 811.5e3;              % meter
mass = 1250;             % kg
area = 2.2^2;              % m^2
AdM = area/mass;

% To Kepler Elements
a = R + h;                   % meter
I = deg2rad(98.622);         % radiant
e = 0.0002125;
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant

GM = 3.9865005e14;              % m^3/s^2
T = sqrt((a^3 * 4* pi) / (GM)); % s

%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');
tspan = 0:24*3600:24*3600*365*2; % integral time

for i=1:length(tspan)-1
    tspan_split=[tspan(i),tspan(i+1)];
    t0 = starttime+tspan(i)/3600/24;
    if i==1
%         result_noforce = orbit_integral(a,e,I,Omega,...
%             w,M,AdM,t0,tspan_split,"noforce");

        result_harris_priester = orbit_integral(a,e,I,Omega,...
            w,M,AdM,t0,tspan_split,"hp");

%         result_msis = orbit_integral(a,e,I,Omega,...
%             w,M,AdM,t0,tspan_split,"msis");
    else
%         % noforce
%         a = result_noforce(end,2);              % meter
%         e = result_noforce(end,3);      % radiant
%         I = result_noforce(end,4);
%         Omega = result_noforce(end,5);   % radiant
%         w = result_noforce(end,6);       % radiant
%         M = result_noforce(end,7);       % radiant
%         result_noforce = orbit_integral(a,e,I,Omega,...
%             w,M,AdM,t0,tspan_split,"noforce");
% 
        % harris-priester model
        a = result_harris_priester(end,2);      % meter
        e = result_harris_priester(end,3);      % radiant
        I = result_harris_priester(end,4);
        Omega = result_harris_priester(end,5);   % radiant
        w = result_harris_priester(end,6);       % radiant
        M = result_harris_priester(end,7);       % radiant
        result_harris_priester = orbit_integral(a,e,I,Omega,...
            w,M,AdM,t0,tspan_split,"hp");

%         % msis model
%         a = result_msis(end,2);      % meter
%         e = result_msis(end,3);      % radiant
%         I = result_msis(end,4);
%         Omega = result_msis(end,5);   % radiant
%         w = result_msis(end,6);       % radiant
%         M = result_msis(end,7);       % radiant
%         result_msis = orbit_integral(a,e,I,Omega,...
%             w,M,AdM,t0,tspan_split,"msis");
    end
%     name1 = ['orbit_data/result_noforce_',num2str(i),'.mat'];
%     save(name1,'result_noforce')

    name2 = ['orbit_data/result_hp_',num2str(i),'.mat'];
    save(name2,'result_harris_priester')

%     name3 = ['orbit_data/result_msis_',num2str(i),'.mat'];
%     save(name3,'result_msis')
    fprintf("%d day done\n",i)
end

