clearvars;close all;clc

satellitestatistic = import_satistic_data('satellite_statistic.csv');

fig = figure;
bar(satellitestatistic{:,1},satellitestatistic{:,2})
xlabel('year')
ylabel('objects counting')
grid on
xticks(1960:5:2025)
xlim([1955,2023])
title('Space Objects Count')
set(gca,'yticklabel',get(gca,'ytick'));
set(gca,'FontSize',24)
% pbaspect([3,1,1])

% figure
% hold on
% t = satellitestatistic{:,1};
% data = [satellitestatistic{:,3},satellitestatistic{:,4}];
% bar(t,data)
% xlabel('year')
% ylabel('objects counting')
% xticks(1960:5:2025)
% xlim([1955,2023])
% legend('new object','disappeared objects')
% set(gca,'yticklabel',get(gca,'ytick'));
% set(gca,'FontSize',24)
% pbaspect([3,1,1])
