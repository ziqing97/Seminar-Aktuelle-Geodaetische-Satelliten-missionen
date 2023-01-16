clearvars;close all;clc

satellitestatistic = import_satistic_data('satellite_statistic.csv');

figure
errorbar(satellitestatistic{:,1},satellitestatistic{:,2},satellitestatistic{:,4},satellitestatistic{:,3})
xlabel('year')
ylabel('objects count')
pbaspect([3,1,1])
grid on
xticks(1955:5:2025)
xlim([1955,2023])
title('Space Objects Count in Low Earth Orbit')
set(gca,'FontSize',24)
set(gca,'yticklabel',get(gca,'ytick'));

data_count = satellitestatistic{:,2};
d_c = diff(data_count);
figure
plot(satellitestatistic{2:end,1},d_c)
grid on
xticks(1960:5:2025)
