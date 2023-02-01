clearvars;close all;clc

satellitestatistic = import_satistic_data('satellite_statistic.csv');

figure
bar(satellitestatistic{:,1},satellitestatistic{:,2})
xlabel('year')
ylabel('objects counting')
grid on
xticks(1955:5:2025)
xlim([1955,2023])
title('Space Objects Count')
set(gca,'yticklabel',get(gca,'ytick'));
set(gca,'FontSize',24)
pbaspect([3,1,1])

figure
hold on
plot(satellitestatistic{:,1},satellitestatistic{:,3})
plot(satellitestatistic{:,1},satellitestatistic{:,4})
xlabel('year')
ylabel('objects counting')
xticks(1955:5:2025)
xlim([1955,2023])
legend('new object','disappeared objects')
set(gca,'yticklabel',get(gca,'ytick'));
set(gca,'FontSize',24)
pbaspect([3,1,1])
