%% generate trend of one integration
clc;close all;clearvars
files1 = dir('E:\orbit\orbit_e_0_AdM_0.01');
files2 = dir('E:\orbit\orbit_e_0_AdM_0.05');

%%
countlist = zeros(length(files1)-2,1);
for i=1:length(files1)
    if files1(i).isdir
        continue
    else
        num = str2double(files1(i).name(11:end-4));
        countlist(i) = num;
    end
end

array_a = [];
array_e = [];
array_t = [];

for i=1:length(countlist)-2
index = find(countlist == i);
load([files1(index).folder,'\',files1(index).name])

array_t = [array_t;result_harris_priester(1:20:end,1)];
array_a = [array_a;result_harris_priester(1:20:end,2)];
array_e = [array_e;result_harris_priester(1:20:end,3)];
end

array_t1 = array_t/3600/24;
array_e1 = array_e;
array_a1 = array_a;
%%
countlist = zeros(length(files2)-2,1);
for i=1:length(files2)
    if files2(i).isdir
        continue
    else
        num = str2double(files2(i).name(11:end-4));
        countlist(i) = num;
    end
end
array_a = [];
array_e = [];
array_t = [];

for i=1:length(countlist)-2
index = find(countlist == i);
load([files2(index).folder,'\',files2(index).name])

array_t = [array_t;result_harris_priester(1:20:end,1)];
array_a = [array_a;result_harris_priester(1:20:end,2)];
array_e = [array_e;result_harris_priester(1:20:end,3)];
end

array_t2 = array_t/3600/24;
array_e2 = array_e;
array_a2 = array_a;

figure
subplot(2,1,1)
hold on
pp1 = plot(array_t1, array_e1);
pp2 = plot(array_t2, array_e2);
xlabel('Time (Day)')
ylabel('Eccentricity')
legend('A/M=0.01','A/M=0.05')
set(gca,'FontSize',20)
ax = ancestor(pp1, 'axes');
ax.YAxis.Exponent = 0;
ax = ancestor(pp2, 'axes');
ax.YAxis.Exponent = 0;

subplot(2,1,2)
hold on
plot(array_t1, (array_a1-6378137)/1000)
plot(array_t2, (array_a2-6378137)/1000)
legend('a - R [km]')
xlabel('Time (Day)')
ylabel('Height [km]')
legend('A/M=0.01','A/M=0.05')
set(gca,'FontSize',20)

sgt = sgtitle('Compare results from different area mass ratio with h=600km, e=0');
sgt.FontSize = 24;