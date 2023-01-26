clc;close all;clearvars

%% h from 300 to 1000 0,0
h_array = (300:10:1000)';
h_array = h_array * 1000;

rho_hp = nan(length(h_array),1);
rho_msis = nan(length(h_array),1);

for i=1:length(h_array)
    rho_hp(i) = density_hp(h_array(i));
    [~, rho] = atmosnrlmsise00(h_array(i),0,0,2023,1,0);
    rho_msis(i) = rho(6);
end 

figure
subplot(2,1,1)
hold on
plot(h_array/1000,rho_hp)
plot(h_array/1000,rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
legend('harris-priester','msis00')
title('density of two model at latitude 0, longitude 0')
set(gca,'FontSize',14)

subplot(2,1,2)
plot(h_array/1000,rho_hp-rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
title('density difference between two model at latitude 0, longitude 0')
set(gca,'FontSize',14)

%% h from 300 to 1000
h_array = (300:10:1000)';
h_array = h_array * 1000;

rho_hp = nan(length(h_array),1);
rho_msis = nan(length(h_array),1);

for i=1:length(h_array)
    rho_hp(i) = density_hp(h_array(i));
    [~, rho] = atmosnrlmsise00(h_array(i),90,0,2023,1,0);
    rho_msis(i) = rho(6);
end 

figure
subplot(2,1,1)
hold on
plot(h_array/1000,rho_hp)
plot(h_array/1000,rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
legend('harris-priester','msis00')
title('density of two model at nord pol')
set(gca,'FontSize',14)

subplot(2,1,2)
plot(h_array/1000,rho_hp-rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
title('density difference between two model at nord pol')
set(gca,'FontSize',14)

%% h from 800 to 1000
h_array = (800:10:1000)';
h_array = h_array * 1000;

rho_hp = nan(length(h_array),1);
rho_msis = nan(length(h_array),1);

for i=1:length(h_array)
    rho_hp(i) = density_hp(h_array(i));
    [~, rho] = atmosnrlmsise00(h_array(i),0,0,2023,1,0);
    rho_msis(i) = rho(6);
end 

figure
subplot(2,1,1)
hold on
plot(h_array/1000,rho_hp)
plot(h_array/1000,rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
legend('harris-priester','msis00')
title('density of two model at nord pol')
set(gca,'FontSize',14)

subplot(2,1,2)
plot(h_array/1000,rho_hp-rho_msis)
ylabel('\rho [kg/m^3]')
xlabel('h [km]')
title('density difference between two model at nord pol')
set(gca,'FontSize',14)

%% check the difference at different location of msis00 at 400 km
lat = -90:90;
lon = -180:180;
[LAT, LON] = meshgrid(lat,lon);
[a,b] = size(LAT);
rho_mat = nan(a,b);

for i=1:length(lat)
    for j=1:length(lon)
        [~,temp] = atmosnrlmsise00(400,lat(i),lon(j),2023,1,0);
        rho_mat(j,i) = temp(6);
    end
end

figure
imagesc(rho_mat')
xticks(1:45:361)
yticks(1:45:181)
xticklabels(-180:45:180)
yticklabels(90:-45:-90)
xlabel('longitude')
ylabel('latitude')
title('Atmosphere density on height 400 km using msis00 model')
c = colorbar;
c.Label.String = '[\rho kg/m^3]';
set(gca,'FontSize',14)