clc;close all;clearvars

warning('off')

%% h from 300 to 1000 0,0
expo = -3:1:2;
tick = 10.^expo;

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
plot(h_array/1000,rho_hp*1e12)
plot(h_array/1000,rho_msis*1e12)
ylabel('\rho [g/km^3]')
xlabel('h [km]')
legend('harris-priester','msis00')
title('density of two model at latitude 0, longitude 0')
set(gca,'FontSize',24)
% set(gca, 'YScale', 'log')
% set(gca,'YTick',tick)

subplot(2,1,2)
plot(h_array/1000,(rho_hp-rho_msis)*1e12)
ylabel('\rho [g/km^3]')
xlabel('h [km]')
title('density difference between two model at latitude 0, longitude 0')
set(gca,'FontSize',24)
set(gca, 'YScale', 'log')
set(gca,'YTick',tick)

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
plot(h_array/1000,rho_hp*1e12)
plot(h_array/1000,rho_msis*1e12)
ylabel('\rho [g/km^3]')
xlabel('h [km]')
legend('harris-priester','msis00')
title('density of two model at Arctic point')
% set(gca,'YTick',tick)
set(gca,'FontSize',24)
% set(gca, 'YScale', 'log')
% ylim([0.004,100])

subplot(2,1,2)
plot(h_array/1000,(rho_hp-rho_msis)*1e12)
ylabel('\rho [g/km^3]')
xlabel('h [km]')
title('density difference between two model at Arctic point')
set(gca,'YTick',tick)
set(gca,'FontSize',24)
set(gca, 'YScale', 'log')
ylim([0.004,100])


% %% check the difference at different location of msis00 at 400 km
% lat = -90:90;
% lon = -180:180;
% [LAT, LON] = meshgrid(lat,lon);
% [a,b] = size(LAT);
% rho_mat = nan(a,b);
% 
% for i=1:length(lat)
%     for j=1:length(lon)
%         [~,temp] = atmosnrlmsise00(400000,lat(i),lon(j),2023,1,0);
%         rho_mat(j,i) = temp(6);
%     end
% end
% 
% figure
% imagesc(rho_mat'*1e12)
% xticks(1:45:361)
% yticks(1:45:181)
% xticklabels(-180:45:180)
% yticklabels(90:-45:-90)
% xlabel('longitude')
% ylabel('latitude')
% title('Atmosphere density on height 400 km using msis00 model UTC 0:00')
% c = colorbar;
% c.Label.String = '[\rho g/km^3]';
% set(gca,'FontSize',24)
% 
% 
% %% check the difference at different location of msis00 at 400 km
% lat = -90:90;
% lon = -180:180;
% [LAT, LON] = meshgrid(lat,lon);
% [a,b] = size(LAT);
% rho_mat = nan(a,b);
% 
% for i=1:length(lat)
%     for j=1:length(lon)
%         [~,temp] = atmosnrlmsise00(400000,lat(i),lon(j),2023,1,3600*12);
%         rho_mat(j,i) = temp(6);
%     end
% end
% 
% figure
% imagesc(rho_mat'*1e12)
% xticks(1:45:361)
% yticks(1:45:181)
% xticklabels(-180:45:180)
% yticklabels(90:-45:-90)
% xlabel('longitude')
% ylabel('latitude')
% title('Atmosphere density on height 400 km using msis00 model UTC 12:00')
% c = colorbar;
% c.Label.String = '[\rho g/km^3]';
% set(gca,'FontSize',24)