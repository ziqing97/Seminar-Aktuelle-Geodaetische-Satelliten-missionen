%% generate trend of one integration
clc;close all;clearvars
files = dir('E:\orbit\old_results\orbit_e005_middle');
countlist = zeros(length(files)-2,1);
for i=1:length(files)
    if files(i).isdir
        continue
    else
        num = str2double(files(i).name(11:end-4));
        countlist(i) = num;
    end
end

array_a = [];
array_e = [];
array_t = [];

for i=1:length(countlist)-2
index = find(countlist == i);
load([files(index).folder,'\',files(index).name])

array_t = [array_t;result_harris_priester(1:20:end,1)];
array_a = [array_a;result_harris_priester(1:20:end,2)];
array_e = [array_e;result_harris_priester(1:20:end,3)];
end

array_t = array_t/3600/24;

array_apo = array_a + array_a .* array_e;
array_per = array_a - array_a .* array_e;

figure
subplot(2,1,1)
pp = plot(array_t, array_e);
xlabel('Time (Day)')
ylabel('Eccentricity')
set(gca,'FontSize',20)
ax = ancestor(pp, 'axes');
ax.YAxis.Exponent = 0;

subplot(2,1,2)
hold on
plot(array_t, (array_per-6378137)/1000)
plot(array_t, (array_apo-6378137)/1000)
legend('perigee height','apogee height')
xlabel('Time (Day)')
ylabel('Height [km]')
set(gca,'FontSize',20)

sgt = sgtitle('a-R = 600 km, e=0.05, A/m=0.004 m^2/kg as start value');
sgt.FontSize = 24;
% %% 
% path = 'E:\orbit\h600';
% e_array = [0,0.01,0.02,0.03,0.04,0.05];
% AdM_array = [0.015,0.025,0.035,0.045,0.055,0.065,0.075];
% 
% time_mat = zeros(length(e_array),length(AdM_array));
% 
% max_count = 365 * 40;
% folder_list = dir(path);
% for i=1:length(folder_list)
%     if folder_list(i).name == "." || folder_list(i).name == ".."
%         continue
%     end
%     e = str2double(folder_list(i).name(9:12));
%     m = find(e_array == e);
%     AdM = str2double(folder_list(i).name(end-4:end));
%     n = find(AdM_array == AdM);
%     file_list = dir([folder_list(i).folder,'\',folder_list(i).name]);
%     t_inte = length(file_list)-2;
%     time_mat(m,n) = t_inte;
% end
% 
% figure
% imagesc(time_mat)
% c = colorbar;
% c.Label.String = 'Time [day]';
% xticklabels(AdM_array)
% yticklabels(e_array)
% xlabel('area mass ratio [m^2/kg]')
% ylabel('eccentricity')
% title('Time that object needs to reentry and drop (a-R=600 km)')
% set(gca,'FontSize',24)