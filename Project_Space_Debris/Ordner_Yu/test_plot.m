%%
clc;close all;clearvars
files = dir('C:\orbit_e005_middle');
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
plot(array_t, array_e)
xlabel('Time (Day)')
ylabel('Eccentricity')
set(gca,'FontSize',24)
pbaspect([3,1,1])

figure
hold on
plot(array_t, (array_per-6378137)/1000)
plot(array_t, (array_apo-6378137)/1000)
legend('perigee height','apogee height')
xlabel('Time (Day)')
ylabel('Height [km]')
set(gca,'FontSize',24)
pbaspect([3,1,1])

