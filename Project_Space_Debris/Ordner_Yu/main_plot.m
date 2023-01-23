%%
clc;close all;clearvars
load('result_noforce.mat')
load('result_harris_priester.mat')

%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');
t_noforce = starttime + result_noforce(:,1)/3600/24;
t_harris_priester = starttime + result_harris_priester(:,1)/3600/24;

%%
figure
hold on
plot(t_noforce,(result_noforce(:,2)-6378137)/1000)
plot(t_harris_priester,(result_harris_priester(:,2)-6378137)/1000)
set(gca,'FontSize',20)
xlabel("time")
ylabel("a - R (km)")
pbaspect([3,1,1])

figure
hold on
plot(t_noforce,result_noforce(:,3))
plot(t_harris_priester,result_harris_priester(:,3))
set(gca,'FontSize',20)
xlabel("time")
ylabel("e")
pbaspect([3,1,1])