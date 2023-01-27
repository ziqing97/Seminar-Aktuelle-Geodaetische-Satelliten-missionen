%%
clc;close all;clearvars
files = dir('E:\orbit_m1250_ar5_h1000_e01');
countlist = zeros(length(files)-2,1);
for i=1:length(files)
    if files(i).isdir
        continue
    else
        num = str2double(files(i).name(11:end-4));
        countlist(i) = num;
    end
end

figure
hold on
for i=1:length(countlist)-2
index = find(countlist == i);
load([files(index).folder,'\',files(index).name])
plot(result_harris_priester(:,1),result_harris_priester(:,2)-6378137)
end

figure
hold on
for i=1:length(countlist)-2
index = find(countlist == i);
load([files(index).folder,'\',files(index).name])
plot(result_harris_priester(:,1),result_harris_priester(:,3))
end

figure
hold on
for i=1:length(countlist)-2
index = find(countlist == i);
load([files(index).folder,'\',files(index).name])
a=result_harris_priester(:,2);
e=result_harris_priester(:,3);
apo=a+a.*e;
peri=a-a.*e;
plot(result_harris_priester(:,1),apo-6378137)
plot(result_harris_priester(:,1),peri-6378137)
end

figure
hold on
for i=1:length(countlist)-2
index = find(countlist == i);
load([files(index).folder,'\',files(index).name])
a=result_harris_priester(:,2);
e=result_harris_priester(:,3);
apo=a+a.*e;
peri=a-a.*e;
plot(result_harris_priester(:,1),apo-peri)
end