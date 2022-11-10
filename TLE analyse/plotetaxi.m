function [] = plotetaxi(data, name)
xi = data.e .* cosd(data.mean_anomaly);
eta = data.e .* sind(data.mean_anomaly);

time = datetime(data.time,"ConvertFrom","datenum");
year_change = [];
year_neu = [];
colour = ['r', 'g', 'b', 'y', 'c', 'm', 'k'];
for i = 2:length(time)
    year = time(i).Year;
    year_old = time(i-1).Year;
    if year ~= year_old
        year_change = [year_change, i-1];
        year_neu = [year_neu, year_old];
    end
end
year_neu = [year_neu, year];
j = 1;
legende = [];
figure
for i = 1:length(year_change)
    plot(xi(j:year_change(i)),eta(j:year_change(i)),'color', [rand(3,1)])
    hold on
    legende = [legende, string(year_neu(i))];
    j = year_change(i)+1;
end

plot(xi(j:end),eta(j:end))
hold on
legend(legende)
grid on
title(name)
xlabel('\xi')
ylabel('\eta')
end